#Distance between the center of mass of two atoms selections

set sel1 [atomselect top "protein"]
set sel2 [atomselect top "resname K36"]

set nf [molinfo top get numframes]

set outfile [open dist_out.dat w]

for {set f 0} {$f < $nf} {incr f} {
    $sel1 frame $f
    $sel2 frame $f
    set com1 [measure center $sel1 weight mass]
    set com2 [measure center $sel2 weight mass]
    set distance [veclength [vecsub $com1 $com2]]
    puts $outfile $f\t$distance
}

close $outfile
