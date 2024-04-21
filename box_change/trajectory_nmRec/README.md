
# Analysis with INTERACTIONS_VS_TIME 

What files do we need?
1. A `.pdb` file `nmRec.pdb` containing only the protein. All the residues must have their chain. This file can be obtained with pymol starting from `ref_editconf`. The command in pyMOL is 
```
select polymer.protein
``` 
2. A trajectory containing only the protein:
```
gmx trjconv -s md.tpr -f trj_center.xtc -o prot.xtc
```
After this you do `conda activate pyinteraph-env` and proceed in 3 steps:
1. Get the `.log` and `.npy` files. Be careful because your residue numeration in this particular case starts from 2, so you have to shift all the numbers of the residues you are interested in by 1 in the `hb_imp.txt` file:
```
python ../../../../Trial/INT_VS_TIME_package/main.py -t prot.xtc -s nmRec.pdb -y --hb-imp hb_imp.txt
```
2. Get the files with the occurrences of interactions:
```
python ../../../../INTERACTIONS_VS_TIME/INT_VS_TIME_package/main.py -gen_data -imp_res pocket.txt -imp_inter pocket_int.txt -LOG hbonds_nmRec_nmRec.log -XPM hbonds_nmRec_nmRec.npy -s nmRec.pdb -t prot.xtc -nprots 1 -nres 201
```
Remember that the `.txt` files must not have blank spaces left. 

3. Do the plot bars:
```
python ../../../../INTERACTIONS_VS_TIME/INT_VS_TIME_package/main.py -do_bars -nprots 1 -nres 201 -t prot.xtc -intervals intervals.txt -data hb_res.txt -s nmRec.pdb
```
You can also use `hc_inter.txt` instead of `hc_res.txt`.




 


