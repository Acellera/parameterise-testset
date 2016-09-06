#!/bin/bash
#PBS -lselect=1:ncpus=4:mem=2gb
#PBS -lwalltime=72:0:0
#PBS -J 1-119
#PBS -N param
if [ "$PBS_O_WORKDIR" != "" ]; then
 cd "$PBS_O_WORKDIR"
fi

D=$(head -$PBS_ARRAY_INDEX list | tail -1)
cd $D

rm -rf parameters* plots* log.txt

export PYTHONPATH="$HOME/working/acellera/htmd"
python $HOME/working/acellera/htmd/htmd/newparameterization/cli.py -m input.mol2 -f GAFF2  > log-gaff2.txt 2>&1
python $HOME/working/acellera/htmd/htmd/newparameterization/cli.py -m input.mol2 -f CGENFF > log-cgen.txt 2>&1

