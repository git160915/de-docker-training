FROM cluster-base

# -- dbt install

RUN apt update && \
    apt upgrade -y && \
    sudo apt-get install git libpq-dev python-dev python3-pip && \
    apt remove python-cffi && \
    pip install --upgrade cffi && \
    pip install cryptography~=3.4

# -- Runtime

EXPOSE 80
WORKDIR ${SHARED_WORKSPACE}
CMD ["bash"]