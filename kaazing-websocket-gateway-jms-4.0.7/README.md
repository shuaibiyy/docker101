Kaazing WebSocket Gateway JMS Edition 4.0.7
===========================================

Build an Gateway image:

    sudo docker build -t demo/kaazing-jms-gateway-4.0.7 .

Run the Gateway image:

    sudo docker run -id -p=8000:8000 -p=8001:8001 demo/kaazing-jms-gateway-4.0.7

Try out the gateway:

    <DOCKER_HOST_IP>:8001

# Note:
* DOCKER_HOST_IP refers to the ip of the host on which the container is running. If you're using boot2docker, this would be boot2docker's ip.