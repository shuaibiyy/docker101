#!/bin/sh
# Cleanup docker files: untagged containers and images.
#
# Use `cleanup_untagged_containers_and_images.sh -n` for a dry run to see what would be deleted.

untagged_containers() {
	sudo docker ps -a | tail -n +2 | awk '$2 ~ "^[0-9a-f]+$" {print $'$1'}'
}

untagged_images() {
	# NOTE: intermediate images (via -a) seem to only cause
	# "Error: Conflict, foo wasn't deleted" messages.
	# docker images -a | awk '$1 == "<none>" {print $'$1'}'
	sudo docker images | tail -n +2 | awk '$1 == "<none>" {print $'$1'}'
}

# Dry-run.
if [ "$1" = "-n" ]; then
	echo "=== Containers with uncommitted images: ==="
	untagged_containers 0
	echo

	echo "=== Uncommitted images: ==="
	untagged_images 0

	exit
fi
if [ -n "$1" ]; then
	echo "Cleanup docker files: remove untagged containers and images."
	echo "Usage: ${0##*/} [-n]"
	echo "   -n: dry run: display what would get removed."
	exit 1
fi

# Remove containers with untagged images.
echo "Removing containers:" >&2
untagged_containers 1 | xargs --no-run-if-empty sudo docker rm --volumes=true

# Remove untagged images
echo "Removing images:" >&2
untagged_images 3 | xargs --no-run-if-empty sudo docker rmi

