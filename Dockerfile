FROM rootproject/root:6.22.08-ubuntu20.04

USER root
ENV HOME /root

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    python3-setuptools python3-pip sudo \
  && pip3 install jupyterlab metakernel \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN pip3 install matplotlib numpy scipy

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
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.extra_static_paths = [\"$ROOTSYS/js/\"]" >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py
WORKDIR /home/$NB_USER/work

EXPOSE 8888
CMD ["root", "--notebook", "--ip=0.0.0.0"]

