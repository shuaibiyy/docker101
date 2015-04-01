FROM ubuntu:14.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-software-properties && \
    apt-get install software-properties-common python-software-properties -y && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer curl

WORKDIR /opt

RUN curl -L https://s3.amazonaws.com/download.kaazing.com/com/download/jms/4.0.7.596/kaazing-websocket-gateway-jms-4.0.7.tar.gz | tar xzv

COPY conf kaazing-websocket-gateway-jms-4.0.7/conf

CMD ["/bin/bash", "-c", "kaazing-websocket-gateway-jms-4.0.7/bin/gateway.start"]