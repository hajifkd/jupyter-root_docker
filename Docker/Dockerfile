FROM rootproject/root-ubuntu16

USER root
ENV HOME /root

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    python-setuptools \
    python-pip \
    python3-setuptools \
    python3-pip \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen


ENV ROOTSYS /usr/local
ENV PATH $PATH:$ROOTSYS/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$ROOTSYS/lib
ENV PYTHONPATH $ROOTSYS/lib/root:$PYTHONPATH

RUN pip2 install --upgrade pip
RUN pip2 install jupyter metakernel
RUN pip3 install --upgrade pip
RUN pip3 install ipykernel

RUN cp -r $ROOTSYS/etc/root/notebook/kernels/root/ /usr/local/share/jupyter/kernels/

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# User
ENV SHELL=/bin/bash \
    NB_USER=jovyan \
    NB_UID=1000 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
RUN useradd -m -s /bin/bash -u $NB_UID $NB_USER
RUN echo "jovyan ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/jovyan

USER $NB_UID
ENV HOME /home/$NB_USER
RUN mkdir /home/$NB_USER/work
RUN mkdir /home/$NB_USER/.jupyter
WORKDIR /home/$NB_USER/work

EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]

