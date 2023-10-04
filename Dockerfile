# Fetch Ubuntu
FROM ubuntu:22.04

# Install prerequisites

RUN \ 
    apt update && \
    apt install -y git python3 && \
    apt install -y cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential

# Install Pico SDK
RUN \
    mkdir -p /project/src/ && \
    cd /project/ && \
    git clone https://github.com/raspberrypi/pico-sdk.git --branch master && \
    cd pico-sdk/ && \
    git submodule update --init && \
    cd /

# Set the Pico SDK environment varable 
ENV PICO_SDK_PATH=/project/pico-sdk/
# Copy in ourn source file 
COPY src/* /project/src/

# Build project
RUN \
    ls && \
    mkdir -p /project/src/build && \
    cd /project/src/build && \
    cmake .. && \
    make

# Comand that will be invoked when the container starts
ENTRYPOINT ["/bin/bash"]


# docker build -t pico-builder-image .

# docker create --name pico-builder-container pico-builder-image

# docker cp pico-builder-container:/project/src/build/blink.uf2 ./blink.uf2
