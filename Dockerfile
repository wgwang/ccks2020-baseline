FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
MAINTAINER hemengjie@datagrand.com

# Install basic dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        libopencv-dev \
        libsnappy-dev \
        python-dev \
        python-pip \
        tzdata \
        vim


# Install anaconda for python 3.6
RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    echo "export PATH=/opt/conda/bin:$PATH" >> ~/.bashrc


# Set timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Set the locale
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


COPY ./requirements.txt /root/doc_compare/
COPY ./start_server.py /root/doc_compare/
COPY ./data /root/doc_compare/data
COPY ./src /root/doc_compare/src



WORKDIR /root/doc_compare
#pip 依赖

RUN cd /root/doc_compare/
RUN /opt/conda/bin/conda install tensorflow-gpu -y

RUN pip install -r requirements.txt -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com
RUN rm /root/doc_compare/requirements.txt

EXPOSE 11000
CMD ["python","start_server.py"]