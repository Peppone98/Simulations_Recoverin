
# Folder organization

1. `wt_mdyn`:  `wt` stands for "well-tempered". It contains the metadynamics simulations
2. `tpr_generation`: It contains the procedure for the generation of the `.tpr` files for the four cases 
- non-myristoylated Recoverin (`nmRec`)
- non-myristoylated Recoverin in complex with GRK1 (`nmRec_GRK1`)
- Recoverin in membrane (`membr_Rec`)
- Recoverin with GRK1 in membrane (`membr_Rec_GRK1`)
It contains as well 10 ns of unbiased simulations. 
3. `explorative_meta`: it contains the analysis of metadynamics runs performed with different methodologies reported in the plumed manual (for instance, parallel bias metadynamics, frequency adapted metadynamics and so on).
4. `benchmarks`: contains the benchmarks on CPU/GPU of both `nmRec` and `membr_Rec`
5. `ideas`: contains some possible ideas such as the coarse-grained metadynamics and so on. This folder does not present any type of analysis, it's purely speculative
6. `box_change`: the box size is changed in order to let the ion sample the unbound state without interacting with the nearest periodic image of the protein. Essentially, the steps described in `tpr_generation` are performed again. 


![funnel_bias_30ns](https://github.com/Peppone98/Simulations_Recoverin/assets/117660597/015c8343-37ff-4e61-a481-d4eec35c04cb)
*Position of the Calcium ion during biased funnel metadynamics simulation*

https://github.com/Peppone98/Simulations_Recoverin/assets/117660597/cd7b8e35-40c2-4247-8461-5d906496f898

![smaller_funnel](https://github.com/Peppone98/Simulations_Recoverin/assets/117660597/8682b707-64f4-400e-aba8-b8019a9dfc30)
*Representation of the funnel restraint*


# Observations 

I think that the multiple walker is the best protocol as it provides a huge speedup. Moreover, the walkers can be differentiated in terms of height and width of the Gaussians and bias factor as well. 

Another protocol, which is explicitly treated in `wt_mdyn` is the funnel metadynamics.  


