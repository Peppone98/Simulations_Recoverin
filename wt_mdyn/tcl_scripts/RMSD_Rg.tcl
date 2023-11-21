#Script for RMSD and Rg

set out_1 [open RMSD.dat w]
set out_2 [open Rg.dat w]

set ref_0 [atomselect top "protein and name CA" frame 0]
set ref [atomselect top "protein and name CA"]
set nf [molinfo top get numframes]

for {set f 0 } {$f < $nf} {incr f} {
    $ref frame $f
    
    #measure and print RMSD, Rg and RMSF
    set RMSD [measure rmsd $ref $ref_0]
    set RG [measure rgyr $ref]
    puts $out_1 $f\t$RMSD
    puts $out_2 $f\t$RG
    
}

for {set f 0 } {$f < $nf} {incr f} {
    $ref frame $f
    
    #measure and print RMSD, Rg and RMSF
    set RMSD [measure rmsd $ref $ref_0]
    set RG [measure rgyr $ref]
    puts $out_1 $f\t$RMSD
    puts $out_2 $f\t$RG
    
}

close $out_1
close $out_2