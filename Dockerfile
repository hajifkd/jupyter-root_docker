FROM debian:latest

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
wget ca-certificates python gfortran build-essential ghostscript vim \
libroot-core libroot-core-dev \
libroot-graf2d-gpad-dev libroot-graf2d-graf-dev \
libroot-graf2d-postscript-dev libroot-graf3d-g3d-dev libroot-hist-dev \
libroot-io-dev libroot-math-mathcore-dev libroot-math-matrix-dev \
libroot-math-physics-dev libroot-montecarlo-eg-dev libroot-net-dev \
libroot-tree-dev

RUN ln -s /bin/true /usr/bin/root
ENV ROOTSYS /

ENV MAKEFLAGS -j 4

RUN useradd -m hep
USER hep

WORKDIR /home/hep

RUN wget --quiet -O- https://launchpad.net/mg5amcnlo/2.0/2.3.0/+download/MG5_aMC_v2.3.3.tar.gz | tar xzf -
WORKDIR MG5_aMC_v2_3_3

RUN echo install Delphes | /home/hep/MG5_aMC_v2_3_3/bin/mg5_aMC
RUN echo install pythia-pgs | /home/hep/MG5_aMC_v2_3_3/bin/mg5_aMC
RUN echo install ExRootAnalysis | /home/hep/MG5_aMC_v2_3_3/bin/mg5_aMC

ENV PYTHONPATH /var/UFO_models

WORKDIR /var/MG_outputs

ADD entry.sh /home/hep/entry.sh
CMD /home/hep/entry.sh
