# Image for the spark cluster in docker

# builder step used to download and configure spark environment
FROM eclipse-temurin:11.0.17_8-jre-focal as builder

# dependencies
RUN apt-get update && apt-get install -y curl wget ssh ca-certificates python3 python3-pip python3-numpy python3-matplotlib python3-scipy python3-pandas python3-simpy
RUN update-alternatives --install "/usr/bin/python" "python" "$(which python3)" 1

ARG shared_workspace=/opt/workspace

ENV SPARK_VERSION=3.2.2 \
HADOOP_VERSION=3.2 \
SPARK_HOME=/opt/spark \
PYTHONHASHSEED=1 \
SHARED_WORKSPACE=${shared_workspace}

RUN pip3 install wget pyspark==${SPARK_VERSION} opendatasets jupyterlab psycopg2-binary

# get spark from apache archive and put in /opt/spark
RUN wget --no-verbose -O apache-spark.tgz "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
&& mkdir -p /opt/spark \
&& mkdir -p /opt/workspace \
&& tar -xf apache-spark.tgz -C /opt/spark --strip-components=1 \
&& rm apache-spark.tgz

VOLUME ${shared_workspace}

WORKDIR ${shared_workspace}

FROM builder as apache-spark

WORKDIR /opt/spark

ENV SPARK_MASTER_PORT=7077 \
SPARK_MASTER_WEBUI_PORT=8080 \
SPARK_LOG_DIR=/opt/spark/logs \
SPARK_MASTER_LOG=/opt/spark/logs/spark-master.out \
SPARK_WORKER_LOG=/opt/spark/logs/spark-worker.out \
SPARK_WORKER_WEBUI_PORT=8080 \
SPARK_WORKER_PORT=7000 \
SPARK_MASTER="spark://spark-master:7077" \
SPARK_WORKLOAD="master"

EXPOSE 8080 7077 6066

RUN mkdir -p $SPARK_LOG_DIR && \
touch $SPARK_MASTER_LOG && \
touch $SPARK_WORKER_LOG && \
ln -sf /dev/stdout $SPARK_MASTER_LOG && \
ln -sf /dev/stdout $SPARK_WORKER_LOG

# shell file to start master/worker
COPY start-spark.sh /

CMD ["/bin/bash", "/start-spark.sh"]