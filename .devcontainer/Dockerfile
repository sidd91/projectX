FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y wget g++ unzip zip vim git
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/bazelisk-linux-amd64 && \
    chmod 755 bazelisk-linux-amd64 && \
    cp bazelisk-linux-amd64 /usr/bin/bazelisk && \ 
    mv bazelisk-linux-amd64 /usr/bin/bazel




