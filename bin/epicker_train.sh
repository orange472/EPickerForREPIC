#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "${SOURCE}" ]; do
  SCRIPTDIR="$(cd -P "$(dirname "${SOURCE}")" >/dev/null && pwd)"
  SOURCE="$(readlink "${SOURCE}")"
  [[ ${SOURCE} != /* ]] && SOURCE="${SCRIPTDIR}/${SOURCE}"
done
PROOT="$(cd -P "$(dirname "${SOURCE}")" >/dev/null && pwd)"

if (($# <= 0)); then
  echo "EPicker : CenterNet-Based Particle Picking for CryoEM"
  echo "Tranining in a continual manner"
  echo "Usage: "
  echo "  EPicker [options]"
  echo "List of options:"
  echo " --data             Image list(.thi) or folder contains images to be picked."
  echo " --testing_data     Path to the folder containing images for testing"
  echo " --training_data    Path to the folder containing images for training"
  echo " --validation_data  Path to the folder containing images for validation"
  echo " --testing_label    Path to the folder containing labels for testing"
  echo " --training_label   Path to the folder containing labels for training"
  echo " --validation_label Path to the folder containing labels for validation"
  echo " --label            Path to the folder containing label coordinate files."
  echo " --label_type       Format of the label coordinate file, thi/star/box/coord. Optional, default thi."
  echo " --sampling_size    Number of particles selected from each training dataset, default 200."
  echo " --load_model       Path to the previous model."
  echo " --load_exemplar    Path to the previous exemplar dataset."
  echo " --output_exemplar  Path to output the new exemplar dataset, default ./exemplar_dataset."
  echo " --continual        Train a new model in a continual manner based on loaded model ."
  echo " --exp_id           Output folder, the output model filename is model_last.pth in this folder."
  echo " --mode             Picking mode: particle/vesicle/fiber. Optional, default particle."
  echo " --lr               Learning rate. Optional, default 1e-4."
  echo " --batch_size       Batch size, typically, 4 for one GPU. Optional, default 4."
  echo " --num_epoch        Number of iterations, optional, default 140"
  echo " --sparse_anno      Use this option if just a small (sparse) part of particles are labled."
  echo " --gpus             GPU device ID, multiple GPUs is not supported now. Optional, default 0."

  echo " "
  echo " Note: Three trainning methods are avilable by choosing differnet options:"
  echo " Method 1) Train a new model from scratch"
  echo "           Ignore options: --load_model, -load_exemplar, --output_exemplar, --sampling_size and --continual"
  echo " Method 2) Train a new model by finetuning a previous model specified by --load_model"
  echo "           Ignore options: -load_exemplar, --output_exemplar, --sampling_size and --continual"
  echo " Method 3) Train a new model in continual manner based on a previous model and exemplar dataset"
  echo "           All ignored options in Method 1) should be used"
  echo " "

  exit 0
fi

# PYTHON=${PROOT}/../../python/bin/python3
# env -i $PYTHON ${PROOT}/../main.py $*

python ${PROOT}/../main.py $*
