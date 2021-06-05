ARG base_image_version=latest
FROM ubuntu:${base_image_version}

# -- dbt install

RUN apt update && \
    apt upgrade -y && \
    apt install git vim libpq-dev python-dev python3-pip -y && \
    pip install --upgrade cffi && \
    pip install cryptography~=3.4 && \
    pip install dbt

# -- Runtime

CMD ["bash"]
