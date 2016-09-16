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

#rm -rf parameters* plots* log.txt 

mkdir -p logs
export PYTHONPATH="$HOME/working/acellera/htmd"
for ff in GAFF2 CGENFF; do
	for basis in 6-31g-star cc-pVTZ; do
		python $HOME/working/acellera/htmd/htmd/newparameterization/cli.py --basis $basis -m input.mol2 -f $ff > logs/$ff-$basis.txt 2>&1
	done
done

