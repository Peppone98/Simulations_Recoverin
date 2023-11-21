#Script for the RMSF

set outfile [open RMSF.dat w]

set sel [atomselect top "name CA"]
set val [measure rmsf $sel]

for {set i 0} {$i < [llength $val]} { incr i} {
     
    set RMSF [lindex $val $i]
    puts $outfile $i\t$RMSF
    
}

close $outfile

puts [$sel num]

#llenght returns the number of elements
#lindex returns the element whose index is $i
#i runs over the alpha carbons in the molecule
#the first l stands for "list"