# Advent of Code 2022
# Day 2 : Rock Paper Scissors
# 

$groups = new-object "system.collections.arraylist"

$list = Get-Content .\input.txt

$map = @{
A ='X'
B = 'Y'
C = 'Z'
}

<#
Rock defeats Scissors
x : z
Scissors defeats Paper
z : y
Paper defeats Rock.
y : x
#>
 
$win = @{
x='z'
z='y'
y='x'
}


<# scoring 
rock 1
paper 2
scissor 3

lose 0
draw 3
win 6
#>


$lookup = @{
X = 1
Y = 2
Z = 3
}


## Part 1

$total = 0

foreach ($play in $list) {

  $score = 0
  $round = $play -split " "

  $them = $map.$($round[0])
  $me = $round[1]

  $score += $lookup.$me

  if ($win.$me -eq $them ) {$score +=6 }
  if ($win.$them -eq $me ) {$score +=0 }
  if ($me -eq $them ) {$score += 3 }
 
   $total += $score

  "{0} : {1} : {2} : {3}"-f $them, $me, $score, $total

  


}
$total


## Part 2

$total = 0

foreach ($play in $list) {

  $score = 0
  $round = $play -split " "

  $them = $map.$($round[0])
  $outcome = $round[1]

    <#
    x: lose
    y: draw
    z: win
    #>

  if ($outcome -eq 'y') {  $me =  $them} # this is a draw
  if ($outcome -eq 'x') { $me = $win.$them } # if they win, i've lost
  if ($outcome -eq 'z') { $me = $win.GetEnumerator() | ? Value -eq $them | % key} # if they lose, i've won.

  $score += $lookup.$me

  if ($win.$me -eq $them ) {$score +=6 }
  if ($win.$them -eq $me ) {$score +=0 }
  if ($me -eq $them ) {$score += 3 }
 
   $total += $score

  #"{0} : {1} : {2} : {3}" -f $them, $me, $outcome.$me, $score, $total


}


"Total: {0}" -f $total


