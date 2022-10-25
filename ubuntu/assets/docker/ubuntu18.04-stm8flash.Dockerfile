FROM ubuntu:18.04

LABEL maintainer="xuhaojie<xuhaojie@hotmail.com>"

RUN apt-get update
RUN apt-get install -y git make gcc pkg-config libusb-1.0 libusb-1.0-0-dev

# install stm8flash
ARG TARGET_DIR=/tmp/stm8flash
RUN git clone https://github.com/vdudouyt/stm8flash.git $TARGET_DIR
WORKDIR $TARGET_DIR
RUN make
RUN make install
WORKDIR /
RUN rm -rf $TARGET_DIR

# build 
# docker build -t ubuntu18.04-stm8flash -f ./assets/docker/ubuntu18.04-stm8flash.Dockerfile .

# run
# docker run --rm -it --device /dev/mem:/dev/men --cap-add SYS_RAWIO ubuntu18.04-stm8flash 

# verify in docker
# docker run --rm --device /dev/mem:/dev/men --cap-add SYS_RAWIO ubuntu18.04-stm8flash stm8flash -V

# 清理已经停止的容器. 
# docker rm -v $(docker ps --all --quiet --filter 'status=exited') 