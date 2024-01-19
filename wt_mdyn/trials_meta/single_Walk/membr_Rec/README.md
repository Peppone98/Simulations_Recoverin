
# Analysis with INTERACTIONS_VS_TIME 

What files do we need?
1. A `.pdb` file `Rec.pdb` containing only the protein. All the residues must have their chain. This file can be obtained with pymol starting from `md.gro`. 
2. A trajectory containing only the protein:
```
gmx_mpi trjconv -s md_meta.tpr -f traj_comp.xtc -o prot.xtc -pbc mol -ur compact -center
```
After this you do `conda activate pyinteraph-env` and proceed in 3 steps:
1. Get the `.log` and `.npy` files:
```
python ../INT_VS_TIME_package/main.py -t prot.xtc -s Rec.pdb -nprots 1 -nres 200 -y --hb-imp hb_imp.txt
```
2. Get the files with the occurrences of interactions:
```
python ../INT_VS_TIME_package/main.py -gen_data -imp_res pocket.txt -imp_inter pocket_int.txt -LOG hbonds_Rec_Rec.log -XPM hbonds_Rec_Rec.npy -nprots 1 -nres 200 -s Rec.pdb -t prot.xtc
```
Remember that the `.txt` files must not have blank spaces left. 

3. Do the plot bars:
```
python ../INT_VS_TIME_package/main.py -do_bars -nprots 1 -nres 200 -t prot.xtc -intervals intervals.txt -data hb_res.txt -s Rec.pdb
```
You can also use `hc_inter.txt` instead of `hc_res.txt`.




# Comments on the profiles

# Extend a gromacs simulation

```
gmx convert-tpr -s md_meta.tpr -extend 200000 -o new_md_meta.tpr
gmx mdrun -s next.tpr -cpi state.cpt
```

`timetoextendby`=Extend runtime by this amount (ps)


 


