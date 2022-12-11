# Day 10: Cathode-Ray Tube



$in = Get-Content input.txt
 
$signals = new-object "system.collections.arraylist"

$x = 1
$cyclecount = 0
$markers = @(20,60,100,100,140,180,220)
 
foreach ($instr in $in) {

    $opcode,$operand = $instr -split " "

    if ($opcode -eq 'noop' ) { 
        $cyclecount += 1
        if ($cyclecount -in $markers){ "cycle {0}: {1}" -f $cyclecount, ($x * $cyclecount); $signals.add(($x * $cyclecount))  }
 
    }

    if ($opcode -eq 'addx') { 
        $cyclecount += 1;
        if ($cyclecount -in $markers){ "cycle {0}: {1}" -f $cyclecount, ($x * $cyclecount); $signals.add(($x * $cyclecount))  }
 
        $cyclecount += 1;
        if ($cyclecount -in $markers){ "cycle {0}: {1}" -f $cyclecount, ($x * $cyclecount); $signals.add(($x * $cyclecount))  }

        $x += $operand 
    }
 }
 
 $total = ($signals | Measure-Object -Sum).sum
 
 "total: {0}" -f $total



 ##
 # Part 2
 ##

 
$in = Get-Content input.txt
 
$screen = (new-object 'char[]' 240)

# clear screen
for($x=0; $x -lt 240; $x++) {
    $screen[$x] = "."
    if ($x % 40 -eq 0) {Write-Host}
        write-host $screen[$x]   -NoNewline
}
    

 $x = 1
 $cyclecount = 0

[int]$spriteloc = 1
[int]$column = 0
[int]$row = [math]::DivRem($cyclecount,40,[ref]$column)

 foreach ($instr in $in) {

 $opcode,$operand = $instr -split " "

 if ($opcode -eq 'noop' ) { 
    
    if ($cyclecount % 40 -in (($spriteloc-1),$spriteloc,($spriteloc+1))) { $screen[$cyclecount]="#" } else {$screen[$cyclecount] = "."}
    
    $cyclecount += 1
    $row = [math]::DivRem($cyclecount,40,[ref]$column) 
}

 if ($opcode -eq 'addx') { 
    
    if ($cyclecount % 40 -in (($spriteloc-1),$spriteloc,($spriteloc+1))) { $screen[$cyclecount]="#" } else {$screen[$cyclecount] = "."}
    $cyclecount += 1;
    $row = [math]::DivRem($cyclecount,40,[ref]$column) 
     
    if ($cyclecount %40 -in (($spriteloc-1),$spriteloc,($spriteloc+1)))  { $screen[$cyclecount]="#" } else {$screen[$cyclecount] = "."}
    $cyclecount += 1;
    $row = [math]::DivRem($cyclecount,40,[ref]$column) 
    
  
    $x += $operand 
    $spriteloc = $x 
    "sprite posistion: {0} after cycle {1}" -f $spriteloc,$cyclecount
    "row:column: {0}:{1}" -f $row,$column
    
    }
 }

# Draw the screen 
for($x=0; $x -lt 240; $x++) {
    #$screen[$x] = "."
    if ($x % 40 -eq 0) {Write-Host}

        write-host $screen[$x]   -NoNewline
    }

