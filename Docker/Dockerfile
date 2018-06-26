FROM rootproject/root-ubuntu16

USER root
ENV HOME /root

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    python-setuptools \
    python-pip \
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

RUN pip2 install jupyter metakernel

RUN cp -r $ROOTSYS/etc/root/notebook/kernels/root/ /usr/local/share/jupyter/kernels/

# User
ENV SHELL=/bin/bash \
    NB_USER=jovyan \
    NB_UID=1000 \
    NB_GID=100 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
RUN groupadd wheel -g 11 && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_UID
ENV HOME /home/$NB_USER
RUN mkdir /home/$NB_USER/work
WORKDIR /home/$NB_USER/work

EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]

