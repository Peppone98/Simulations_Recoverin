#!/bin/bash

#I create a pbs that performs 5 minutes long benchmarks

n_cores=(20 20 24 24 24 24 32 32 32 36 36 40 40 48 48 48 48 50 64 64 64 64 72 72)
n_mpiprocs=(10 4 24 12 6 4 16 8 4 18 6 20 10 24 12 8 6 10 32 16 8 4 36 18)

len=${#n_cores[@]}

# Create the folders
mkdir trials_CPU
mkdir trials_GPU
for (( i=0; i<$len; i++ ))
do
  mkdir trials_CPU/trial_${n_cores[i]}_${n_mpiprocs[i]}
  touch trials_CPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
  mkdir trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}
  touch trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
done


# Create the md.pbs files for CPU
for (( i=0; i<$len; i++ ))
do
  echo -e "#!/bin/bash\n#PBS -l select=1:ncpus=${n_cores[i]}:mpiprocs=${n_mpiprocs[i]}:mem=1GB\n#PBS -l walltime=00:05:00
  \n#PBS -q short_cpuQ\n#PBS -N md_${n_cores[i]}_${n_mpiprocs[i]}\n#PBS -o md_${n_cores[i]}_${n_mpiprocs[i]}_out\n#PBS -e md_${n_cores[i]}_${n_mpiprocs[i]}_err
  \n\nmodule load gcc91\nmodule load openmpi-3.0.0\nmodule load BLAS\nmodule load gsl-2.5\nmodule load lapack-3.7.0
  \nmodule load cuda-11.3\n" > trials_CPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs

  awk 'NR==18' template.pbs >> trials_CPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
  awk 'NR==20' template.pbs >> trials_CPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
  awk 'NR==22' template.pbs >> trials_CPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs

  echo -e "\nexport OMP_NUM_THREADS=$(expr ${n_cores[i]} / ${n_mpiprocs[i]})
  \n/apps/openmpi-3.0.0/bin/mpirun -np ${n_mpiprocs[i]} /home/giuseppe.gambini/usr/installations/gromacs/bin/gmx_mpi mdrun -s ../../md_meta.tpr -plumed meta.dat" >> trials_CPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
done


# Create the md.pbs files for GPU
for (( i=0; i<$len; i++ ))
do
  echo -e "#!/bin/bash\n#PBS -l select=1:ncpus=${n_cores[i]}:mpiprocs=${n_mpiprocs[i]}:ngpus=1:mem=1GB\n#PBS -l walltime=00:05:00
  \n#PBS -q short_gpuQ\n#PBS -N md_${n_cores[i]}_${n_mpiprocs[i]}\n#PBS -o md_${n_cores[i]}_${n_mpiprocs[i]}_out\n#PBS -e md_${n_cores[i]}_${n_mpiprocs[i]}_err
  \n\nmodule load gcc91\nmodule load openmpi-3.0.0\nmodule load BLAS\nmodule load gsl-2.5\nmodule load lapack-3.7.0
  \nmodule load cuda-11.3\n" > trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs

  awk 'NR==18' template.pbs >> trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
  awk 'NR==20' template.pbs >> trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
  awk 'NR==22' template.pbs >> trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs

  echo -e "\nexport OMP_NUM_THREADS=$(expr ${n_cores[i]} / ${n_mpiprocs[i]})
  \n/apps/openmpi-3.0.0/bin/mpirun -np ${n_mpiprocs[i]} /home/giuseppe.gambini/usr/installations/gromacs/bin/gmx_mpi mdrun -s ../../md_meta.tpr -plumed meta.dat" >> trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
done


# Create the meta.dat files inside each subfolder
for (( i=0; i<$len; i++ ))
do
  cp meta.dat trials_CPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/
  cp meta.dat trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/
done


