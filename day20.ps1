# --- Day 20: Grove Positioning System ---

# Picture a wagon wheel with numbers written on the rim between the spokes. 
# Lift the number of interest above the wheel, then spin the wheel that number of positions, and re-insert
# When all numbers on the wheel have been visited. Find where the Zero is located ,
# then rotate the wheel 1000,2000, and 3000 times, and look for first number to the right of zero

function rot([System.Collections.ArrayList]$t,[int]$times)
{
    $direction = [math]::Sign($times)

    $rotations = [math]::abs($times)

    while ($rotations -gt 0) {
        
        #rotate array +/- 1
        $last = $t.count - 1
        $first = 0

        # if the number is negative, rotate right
        if ($direction -eq -1 ) { 
            $tmp = $t[$last] 
            [void]$t.RemoveAt($last)
            [void]$t.Insert($first,$tmp)
    
        $rotations--
        # positive, rotate left
        } elseif ($direction -eq 1) {
            $tmp = $t[$first]
            [void]$t.RemoveAt($first)
            [void]$t.add($tmp)

            $rotations--
        }
    }
}

class score {
    [int64]$value
    [int]$originalindex

    score ([int64]$v, [int]$idx) {
        $this.value = $v
        $this.originalindex = $idx
    }
}


#$data= @(1, 2, -3, 3, -2, 0, 4)
$data = Get-Content .\input.txt

$s = New-Object "System.Collections.ArrayList"

for ($x=0; $x -lt $data.Count; $x++) {
    $tmp = [score]::new($data[$x],$x)
    $s.add($tmp)
}

# part 1
#step through each number based on the original index

for  ($x=0; $x-lt $s.Count; $x++) {
    
    # save the current score (number and index) that's about to be moved
    foreach ($i in $s) {        
        if ($i.originalindex -eq $x) {            
            $current = [score]::new($i.value, $i.originalindex);
            break;
        }
    }

    #find current values location on the wheel before rotation
    for ($j=0; $j -lt $s.Count; $j++) { if ($s[$j].originalindex -eq $current.originalindex) {$oldindex = $j;break  } }
    
    $s.RemoveAt($oldindex)
    rot $s ($current.value % $s.Count )
    $s.insert($oldindex,$current)
}

# Locate the index where the value 0 is.
for ($j=0;$j -lt $s.Count; $j++) {
    if ($s[$j].value -eq 0) { $zero = $j}
}

# The wording on the question didnt' make sense to me.
# Originall I thought it meant mixing 1000x, then looking for the value after zero
# But it meant mix once, then spin the wheel.

$total = 0
rol $s 1000
$total += $s[$zero].value
rol $s 1000
$total += $s[$zero].value
rol $s 1000
$total += $s[$zero].value

"Total: {0}" -f $total


##
# Part 2
##

# Multiply each number by 811589153
# Mix 10x.

$key = 811589153

#$data= @(1, 2, -3, 3, -2, 0, 4)
$data = Get-Content .\input.txt

$s = New-Object "System.Collections.ArrayList"

for ($x=0; $x -lt $data.Count; $x++) {
    $tmp = [score]::new(($data[$x]*$key),$x)
    $s.add($tmp)
}

# part 1
#step through each number based on the original index

for ($mixes = 0; $mixes -lt 10; $mixes++) {

    for  ($x=0; $x-lt $s.Count; $x++) {
    
        # save the current score (number and index) that's about to be moved
        foreach ($i in $s) {        
            if ($i.originalindex -eq $x) {            
                $current = [score]::new($i.value, $i.originalindex);
                break;
            }
        }

        #find current values location on the wheel before rotation
        for ($j=0; $j -lt $s.Count; $j++) { if ($s[$j].originalindex -eq $current.originalindex) {$oldindex = $j;break  } }
        
        $s.RemoveAt($oldindex)
        rot $s ($current.value % $s.Count )
        $s.insert($oldindex,$current)
    }
}

# Locate the index where the value 0 is.
for ($j=0;$j -lt $s.Count; $j++) {
    if ($s[$j].value -eq 0) { $zero = $j}
}

$total = 0
rol $s 1000
$total += $s[$zero].value
rol $s 1000
$total += $s[$zero].value
rol $s 1000
$total += $s[$zero].value

"Total: {0}" -f $total
