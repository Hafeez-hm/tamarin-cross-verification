# Base Operating System 
FROM ubuntu:22.04

# Prevent interactive package installation pop-ups
ENV DEBIAN_FRONTEND=noninteractive

# UTF-8 text formatting
ENV LANG=C.UTF-8

# Install background dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    g++ \
    make \
    maude \
    graphviz \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Download and install Tamarin binary directly 
RUN wget https://github.com/tamarin-prover/tamarin-prover/releases/download/1.12.0/tamarin-prover-1.12.0-linux64-ubuntu.tar.gz \
    && tar -xvf tamarin-prover-1.12.0-linux64-ubuntu.tar.gz \
    && mv tamarin-prover /usr/local/bin/ \
    && rm tamarin-prover-1.12.0-linux64-ubuntu.tar.gz

# Set the folder directory where you will work inside the container
WORKDIR /root/protocols

# Protocol folder from your machine into the container 
COPY ./protocols /root/protocols

# Default command that runs if you boot the container without options
CMD ["tamarin-prover", "--version"]