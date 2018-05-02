FROM rootproject/root-ubuntu16

USER root

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
wget ca-certificates python gfortran build-essential ghostscript vim libboost-all-dev

WORKDIR /home/hep

RUN wget --quiet -O- https://launchpad.net/mg5amcnlo/2.0/2.6.x/+download/MG5_aMC_v2.6.2.tar.gz | tar xzf -
WORKDIR MG5_aMC_v2_6_2

ENV ROOTSYS /usr/local
ENV PATH $PATH:$ROOTSYS/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$ROOTSYS/lib

RUN echo install Delphes | /home/hep/MG5_aMC_v2_6_2/bin/mg5_aMC
RUN echo install ExRootAnalysis | /home/hep/MG5_aMC_v2_6_2/bin/mg5_aMC
RUN printf 'install pythia8\ny\n' | /home/hep/MG5_aMC_v2_6_2/bin/mg5_aMC

WORKDIR /home/hep/MG5_aMC_v2_6_2/HEPTools/lhapdf6/share/LHAPDF
# Download a default PDF
RUN wget --quiet -O- https://www.hepforge.org/archive/lhapdf/pdfsets/6.2/NNPDF23_lo_as_0130_qed.tar.gz | tar xzf -

WORKDIR /var/MG_outputs
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/home/hep/MG5_aMC_v2_6_2/HEPTools/lib/

ADD entry.sh /home/hep/entry.sh
CMD /home/hep/entry.sh
