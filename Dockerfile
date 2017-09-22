FROM nvidia/cuda:8.0-cudnn5-devel

MAINTAINER Tobias Lindener <tobias.lindener@gmail.com> 

RUN apt-get update --fix-missing && apt-get install -y wget curl build-essential \
    libpng12-dev libffi-dev bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git pandoc texlive-xetex && \
    apt-get clean && \
    rm -rf /var/tmp /tmp /var/lib/apt/lists/*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.3.14-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh


ENV PATH /opt/conda/bin:$PATH

EXPOSE 8888 6006
VOLUME /notebooks
WORKDIR "/notebooks"
ADD environment.yml /environment.yml
RUN conda env update -f /environment.yml

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0","--allow-root"]


