# Day 8: Treetop Tree House 

# Load an array of arrays to make a 2D grid.
# look up,down,left, right

$in = Get-Content .\input.txt

$grid = new-object "system.collections.arraylist"

foreach ($row in $in) {
    [void]$grid.add($row.ToCharArray())
}

$rows = $grid.Count
$cols = $grid[0].Count

$found = 0

for ($i = 1; $i -lt $rows-1; $i++) {

    for ($j = 1; $j -lt $cols-1; $j++) {

        $n = $grid[$i][$j]
        
        $up = 0
        $down =  0
        $left =  0
        $right = 0
                 
        #up
        for ($u = $i-1; $u -ge 0; $u--) {if ($grid[$u][$j] -ge $n) {$up += 1} }
        #down
        for ($d = $i+1; $d -lt $rows;$d++) {if ($grid[$d][$j] -ge $n) {$down += 1} }
        #left
        for ($l = $j-1; $l -ge 0; $l--) {if ($grid[$i][$l] -ge $n) {$left += 1} }
        #right
        for ($r = $j+1; $r -lt $cols; $r++) {if ($grid[$i][$r] -ge $n) {$right += 1} }
      
        [bool]$visable = ($up -eq 0 -or $down -eq 0  -or $left -eq 0  -or $right -eq 0) 

        if ($visable) { "Found: {0}:{1},{2}" -f $grid[$i][$j],$i,$j; $found++}

    }
  
}

"Interior: {0}" -f $found
"Exterior {0}" -f (2* $rows + 2*($cols-2))
"Total : {0}" -f ((2* $rows + 2*($cols-2)) + $found)

##
# Part 2
##

$in = Get-Content .\input.txt

$grid = new-object "system.collections.arraylist"

foreach ($row in $in) {

    [void]$grid.add($row.ToCharArray())
}

$rows = $grid.Count
$cols = $grid[0].Count

$highscore = 0

for ($i = 1; $i -lt $rows-1; $i++) {

    for ($j = 1; $j -lt $cols-1; $j++) {
        #"checking {0}:{1}" -f $i,$j
        #write-host $grid[$i][$j] -NoNewline
        $n = $grid[$i][$j]
        
        [int]$up = 0
        [int]$down =  0
        [int]$left =  0
        [int]$right = 0  
                 
        #up
         [bool]$stop = $false
        for ($u = $i-1; $u -ge 0 -and -not($stop); $u--) {$tree = $grid[$u][$j]; $up += 1; if ($tree -ge  $n)  {$stop = $true}  }
        #down
         [bool]$stop = $false
        for ($d = $i+1; $d -lt $rows -and -not($stop);$d++) {$tree = $grid[$d][$j]; $down += 1; if ($tree -ge $n) {$stop = $true}   }
        #left
         [bool]$stop = $false
        for ($l = $j-1; $l -ge 0 -and -not($stop); $l--) {$tree = $grid[$i][$l]; $left += 1; if ($tree -ge $n)  {$stop = $true}  }
        #right
         [bool]$stop = $false
        for ($r = $j+1; $r -lt $cols -and -not($stop); $r++) { $tree = $grid[$i][$r];  $right += 1; if ($tree -ge $n) {$stop =$true} }
           
        $scenicscore = $up * $down * $left * $right 
         "scores: {0}:{1}:{2}:{3}: total:{4}" -f $up, $down , $left , $right, $scenicscore
     
        if ($scenicscore -gt $highscore) { $highscore = $scenicscore 
    }
}

"Maximum Scenic Score: {0}" -f $highscore

