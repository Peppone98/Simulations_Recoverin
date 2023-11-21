#!/usr/bin/expect

# We first start the multiple walkers simulations and then the standard ones

cd Walk_MPI
cd nmRec_mw 
qsub meta_MW.pbs 
cd ../nmRec_GRK1_mw
qsub meta_MW.pbs 
cd ../membr_Rec_mw
qsub meta_MW.pbs
cd ../membr_Rec_GRK1_mw
qsub meta_MW.pbs
cd ../..

# Next we start the single walker simulations 

cd nmRec 
qsub meta.pbs 
cd ../nmRec_GRK1
qsub meta.pbs 
cd ../membr_Rec
qsub meta.pbs
cd ../membr_Rec_GRK1
qsub meta.pbs
cd ..

