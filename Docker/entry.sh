#!/bin/bash

MODEL_DIR=${MODEL_DIR-/var/UFO_models}

pushd /home/hep/MG5_aMC_v2_6_2/models

for d in `ls "$MODEL_DIR"`; do
  if [ ! -e $d ]; then
    ln -s "$MODEL_DIR/$d" .
  fi
done

popd

HOME=/var/MG_outputs /home/hep/MG5_aMC_v2_6_2/bin/mg5_aMC

