ARG CASSANDRA_LUCENE_INDEX_VERSION="3.11.3.0"

#Tags	debian:buster-slim
FROM 4a9cd57610d60c20bc1ed3bc9324cc04356e1f3e15b9619dcc37db1138adf9c6 AS debian-for-dev
ARG CASSANDRA_LUCENE_INDEX_VERSION

RUN apt-get update
RUN /usr/bin/apt install  -y curl git gnupg

RUN echo "deb http://ftp.debian.org/debian sid main" > /etc/apt/sources.list.d/debian-sid-main.sources.list
RUN echo "deb http://www.apache.org/dist/cassandra/debian 311x main" > /etc/apt/sources.list.d/cassandra.sources.list

RUN curl -fsSL https://www.apache.org/dist/cassandra/KEYS | apt-key add -
RUN apt-get update
RUN curl -fsSLO "https://github.com/mikefarah/yq/releases/download/3.3.0/yq_linux_amd64" && chmod +x ./yq_linux_amd64 && mv ./yq_linux_amd64 /usr/local/bin/yq
RUN mkdir -p /usr/share/man/man1
RUN /usr/bin/apt install  -y --no-install-recommends openjdk-8-jdk cassandra maven
RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
RUN git clone https://github.com/Stratio/cassandra-lucene-index && cd cassandra-lucene-index && git checkout ${CASSANDRA_LUCENE_INDEX_VERSION} && mvn clean package


FROM bitnami/cassandra:3.11.2
ARG CASSANDRA_LUCENE_INDEX_VERSION
COPY vietnamese_analyzer/models /models
COPY vietnamese_analyzer/*.jar /opt/cassandra/lib/
COPY --from=debian-for-dev /cassandra-lucene-index/plugin/target/cassandra-lucene-index-plugin-${CASSANDRA_LUCENE_INDEX_VERSION}.jar /opt/cassandra/lib
#RUN sed -i -r 's/enable_user_defined_functions=false/enable_user_defined_functions=true/' /etc/cassandra/cassandra.yaml
