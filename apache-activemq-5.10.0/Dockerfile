FROM ubuntu:14.04

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-software-properties && \
    apt-get install software-properties-common python-software-properties -y && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer curl

WORKDIR /opt

RUN curl -L http://repository.apache.org/content/repositories/snapshots/org/apache/activemq/apache-activemq/5.10-SNAPSHOT/apache-activemq-5.10-20140603.133406-78-bin.tar.gz | tar xzv
RUN mv apache-activemq-5.10-SNAPSHOT apache-activemq-5.10 && \
    ln -sf /opt/apache-activemq-5.10 /opt/activemq && \
    ln -sf /opt/activemq/bin/activemq /etc/init.d/ && \
    update-rc.d activemq defaults && \
    /etc/init.d/activemq setup /etc/default/activemq

# Use our own activemq.xml config
ADD conf apache-activemq-5.10/conf

EXPOSE 6155 6156 61616 61617 1099 8161 61613

CMD ["java", "-Xmx1G", "-Dcom.sun.management.jmxremote.ssl=false", "-Dcom.sun.management.jmxremote.password.file=/opt/activemq/conf/jmx.password", "-Dcom.sun.management.jmxremote.access.file=/opt/activemq/conf/jmx.access", "-Djava.util.logging.config.file=logging.properties", "-Dcom.sun.management.jmxremote", "-Djava.io.tmpdir=/opt/activemq/tmp", "-Dactivemq.classpath=/opt/activemq/conf", "-Dactivemq.home=/opt/activemq", "-Dactivemq.base=/opt/activemq", "-Dactivemq.conf=/opt/activemq/conf", "-Dactivemq.data=/opt/activemq/data", "-jar", "/opt/activemq/bin/activemq.jar", "start"]
