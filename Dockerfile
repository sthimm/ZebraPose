# Modified from: https://github.com/lyltc1/ZebraPose

ARG PYTORCH="1.13.1"
ARG CUDA="11.6"
ARG CUDNN="8"

FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-runtime

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y \
    git libgl1 libglib2.0-0 python3-tk 
    # build-essential cmake libeigen3-dev \
    # libgflags-dev libgoogle-glog-dev libopencv-dev

# Build progressivex from source
# RUN git clone --recursive https://github.com/danini/progressive-x /tmp/progressive-x && \
#     pip install /tmp/progressive-x

COPY ../bop_toolkit /tmp/bop_toolkit
RUN pip install -e /tmp/bop_toolkit

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

WORKDIR /zebrapose