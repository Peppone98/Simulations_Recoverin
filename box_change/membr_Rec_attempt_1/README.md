

# Creation of the box 

We take the initial `_start.gro` file. We use the script using `TopoTools` for saving a file containing four periodic images. Then 
```
gmx editconf -f periodic.gro -box 11 11 15 -o periodic_box.gro
```
Then, we have a translation of the center. 

```
gmx editconf -f periodic_box.gro -center 5.0 9.06166 7.5 -o re_box.gro
```
So, `re_box.gro` is the important file. 