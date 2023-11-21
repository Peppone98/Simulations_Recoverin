#CREATE A MATRIX OF DIHEDRALS 

#Unfortunately a column of zeros is produced and I don't know how to remove it
#Maybe we can skip some residues by inserting a m factor (decreasing the dimension of the matrix)

set out_1 [open PHI.dat w]
set out_2 [open PSI.dat w]

set nf [molinfo top get numframes]
set ref [atomselect top "protein and name CA"]
set nres [$ref num]


for {set f 0 } {$f < $nf} {incr f} {
   
    for {set i 0 } {$i < $nres} {incr i} {

        set sel [atomselect top "protein and name CA and resid $i"]
        $sel frame $f
        set PHI [$sel get phi]
        set PSI [$sel get psi]
        puts -nonewline $out_1 \t$PHI
        puts -nonewline $out_2 \t$PSI
    
    }

puts $out_1 \t
puts $out_2 \t

}

close $out_1
close $out_2

