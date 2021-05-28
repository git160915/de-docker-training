#!/bin/sh

# -- Software Stack Version

SPARK_VERSION="3.0.2"
HADOOP_VERSION="3.2"
JUPYTERLAB_VERSION="3.0.15"

# -- Building the Images

docker build \
  --pull --no-cache \
  -f ./src/cluster-base.Dockerfile \
  -t cluster-base .

docker build \
  --no-cache \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg hadoop_version="${HADOOP_VERSION}" \
  -f ./src/spark-base.Dockerfile \
  -t spark-base .

docker build \
  --no-cache \
  -f ./src/spark-master.Dockerfile \
  -t spark-master .

docker build \
  --no-cache \
  -f ./src/spark-worker.Dockerfile \
  -t spark-worker .

docker build \
  --no-cache \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  -f ./src/jupyterlab.Dockerfile \
  -t jupyterlab .
