FROM osgeo/gdal:ubuntu-full-latest

ENV DEBIAN_FRONTEND=noninteractive
SHELL [ "/bin/bash", "-c" ]

RUN apt-get update && apt-get upgrade -y
RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
        build-essential \
        libfreetype6-dev \
        libpng-dev \
        libzmq3-dev \
        python3-dev \
        libspatialindex-dev \
        gdal-bin \
        libgdal-dev \
        libsm6 \
        pip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install -U pip
RUN pip install --upgrade pip setuptools
COPY requirements.txt .
RUN pip install -r requirements.txt
ENV PYTHONPATH $PYTHONPATH:/workspace

RUN mkdir /workspace
WORKDIR /workspace

ENTRYPOINT [ "jupyter-lab", "--NotebookApp.token=''", "--allow-root", "--port", "8888", "--ip=0.0.0.0" ]
