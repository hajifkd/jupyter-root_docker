FROM rootproject/root-conda

USER root
ENV HOME /root

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    apt-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

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
    LANGUAGE=en_US.UTF-8 \
    ROOTSYS=/opt/conda
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
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]

