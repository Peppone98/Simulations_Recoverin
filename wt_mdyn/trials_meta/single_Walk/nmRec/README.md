
# Extend a gromacs simulation

```
gmx convert-tpr -s md_meta.tpr -extend 200000 -o new_md_meta.tpr
gmx mdrun -s next.tpr -cpi state.cpt
```

`timetoextendby`=Extend runtime by this amount (ps)


