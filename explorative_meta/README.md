
# Folder organization 
- The folder `meta_nmRec_1` contains the first metadynamics simulation with a very high rate of deposition (`PACE=100`). The grid $[0, 0.4]$ in this case was chosen too small for our purposes.
- In `meta_nmRec_2` I changed the deposition rate to `PACE=1000` and made the `GRID` similar to the one chosen by Ester, namely $[0, 1.6]$. In this case I also modified the height of the Gaussian to 1 kJ/mol.



# Different options of plumed 


- `CALC_RCT`: this keyword turns on the calculation of the time dependent constant $c(t)$ that we will use when reweighting the simulations. 
- `RCT_USTRIDE`: the update stride for calculating the $c(t)$ reweighting factor.
