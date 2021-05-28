FROM cluster-base

# -- Layer: Apache Spark

ARG spark_version=3.1.1
ARG hadoop_version=3.2

RUN apt update -y && \
    apt install -y curl && \
    apt install -y wget && \
    curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -o spark.tgz && \
    tar -xf spark.tgz && \
    mv spark-${spark_version}-bin-hadoop${hadoop_version} /usr/bin/ && \
    mkdir /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}/logs && \
    rm spark.tgz && \
    cd /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}/jars && \
    wget https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/2.4.1/kafka-clients-2.4.1.jar && \
    wget https://repo1.maven.org/maven2/org/apache/spark/spark-streaming-kafka-0-10_2.12/3.0.2/spark-streaming-kafka-0-10_2.12-3.0.2.jar && \
    wget https://repo1.maven.org/maven2/org/apache/spark/spark-sql-kafka-0-10_2.12/3.0.2/spark-sql-kafka-0-10_2.12-3.0.2.jar && \
    wget https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.8.0/delta-core_2.12-0.8.0.jar && \
    wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime/0.11.1/iceberg-spark-runtime-0.11.1.jar

ENV SPARK_HOME /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV PYSPARK_PYTHON python3

# -- Runtime

WORKDIR ${SPARK_HOME}
