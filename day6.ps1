# Day 6 : Tuning Trouble 

# Use an array of a-z to keep track of count and sum of characters in packet or message
# Sliding window across input using nested for loops

$in = get-content .\input.txt

foreach ($line in $in) {

$lower = [char[]]([char]'a'..[char]'z') 
[int[]] $count = @(0) * $lower.Count 

$found = $false
$msg = $line.ToCharArray()

for ($x = 0 ; $x -lt $msg.Length-4 -and -not($found); $x+=1) {

    for ($y=0; $y -lt 4; $y+=1) {
        $char = $msg[$($x+$y)]
        $index = $lower.indexof($char)
        $count[$index] += 1
    }

    # aggregte all non-zero values
    $check = $count.Where({$_ -ne 0}) | Measure-Object -Sum 
    
    # arrays are zero based, but the reporting of the posistion starts at 1
    if ($check.count -eq 4 -and $check.sum -eq 4) { "found Start of Packet at: {0}:{1}" -f $msg[$($x+3)],$($x+4); $found = $true } 
    
    # reset the counters
    $count = @(0) * $lower.Count  
    }
}


## Part 2

#$in = get-content test.txt
$in = get-content input.txt

foreach ($line in $in) {

$lower = [char[]]([char]'a'..[char]'z') 
[int[]] $count = @(0) * $lower.Count 

$found = $false
$msg = $line.ToCharArray()

for ($x = 0 ; $x -lt $msg.Length-14 -and -not($found); $x+=1) {

    for ($y=0; $y -lt 14; $y+=1) {
        $char = $msg[$($x+$y)]
        $index = $lower.indexof($char)
        $count[$index] += 1
    }

    $check = $count.Where({$_ -ne 0}) | Measure-Object -Sum 
   
    if ($check.count -eq 14 -and $check.sum -eq 14) { "found Start of Message at: {0}:{1}" -f $msg[$($x+13)],$($x+14); $found = $true } 
    
    $count = @(0) * $lower.Count  
    }
}
