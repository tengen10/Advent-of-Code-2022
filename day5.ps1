# Day 5 : Supply Stacks

#########
## Part 1
#########

# used to check for valid boxes
$upper = [char[]]([char]'A'..[char]'Z') 

$instr = get-content .\input.txt
$graph = Get-Content .\graph.txt

# read file from bottom up and put into an array
$line = 1
$list = 1..$graph.Count | ForEach-Object {$graph[-$Line]; $Line++}

#get the position of the columns 
$columns = 1..9 | foreach-object { $list[1].IndexOf("$($_)")}

#create a stack for each 
Get-Variable -Name Stack_* | Remove-Variable
1..9 | foreach-object { new-object "system.collections.stack" | New-Variable -Name $("stack_$_")}

# fill each stack
foreach ($col in $columns) {

    $n = $columns.IndexOf($col) + 1
  
    for ($y=2 ; $y -lt $list.count; $y++) {    
       $box = $list[$y].Substring($col,1)
  
       if ($box -in $upper) { $(Get-Variable -name "stack_$n").value.push($box) }
    }
}

foreach ($op in $instr) {

    $op  = invoke-expression $($op -replace "move","" -replace "from","," -replace "to","," -replace " ","")

    $srcstack = $op[1]
    $dststack = $op[2]
    $moves = $op[0]

    for ($x = 1; $x -le $moves; $x++) {
   
     $box = $(Get-Variable -name "stack_$srcstack").value.pop()
      $(Get-Variable -name "stack_$dststack").value.push($box)      
    }
}

#all moves complete. Pick top box on each
$sb = [System.Text.StringBuilder]::new()
1..9 | foreach-object {$box = $(get-Variable -Name "stack_$_").value.peek(); [void]$sb.Append($box)}

$sb.ToString()


#########
## Part 2
#########

# used to check for valid boxes
$upper = [char[]]([char]'A'..[char]'Z') 

$instr = get-content .\input.txt
$graph = Get-Content .\graph.txt

# read file from bottom up and put into an array
$line = 1
$list = 1..$graph.Count | ForEach-Object {$graph[-$Line]; $Line++}

#get the position of the columns 
$columns = 1..9 | foreach-object { $list[1].IndexOf("$($_)")}

#create a stack for each 
Get-Variable -Name Stack_* | Remove-Variable
1..9 | foreach-object { new-object "system.collections.stack" | New-Variable -Name $("stack_$_")}

# fill each stack
foreach ($col in $columns) {

    $n = $columns.IndexOf($col) + 1
  
    for ($y=2 ; $y -lt $list.count; $y++) {    
       $box = $list[$y].Substring($col,1)
  
       if ($box -in $upper) { $(Get-Variable -name "stack_$n").value.push($box) }
    }
}


foreach ($op in $instr) {

    $op  = invoke-expression $($op -replace "move","" -replace "from","," -replace "to","," -replace " ","")

    $srcstack = $op[1]
    $dststack = $op[2]
    $moves = $op[0]

    $tmpstack = new-object "system.collections.stack"

    for ($x = 1; $x -le $moves; $x++) {

      $box = $(Get-Variable -name "stack_$srcstack").value.pop()
      $tmpstack.push($box)
    }
    while ($tmpstack.count -gt 0 ) {  
      $box = $tmpstack.pop()
      $(Get-Variable -name "stack_$dststack").value.push($box)
    }
}

#all moves complete. Pick top box on each
$sb = [System.Text.StringBuilder]::new()
1..9 | foreach-object {$box = $(get-Variable -Name "stack_$_").value.peek(); [void]$sb.Append($box)}

$sb.ToString()










