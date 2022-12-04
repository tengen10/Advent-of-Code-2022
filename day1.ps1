# Advent of Code Day 1

# Part 1 & 2

$groups = new-object "system.collections.arraylist"

$list = Get-Content .\input.txt

foreach ($i in $list) {
$sum += $i
if ($i -eq '') {
    [void]$groups.add($sum)
    $sum = 0
    }
}


# Part 1 solution
$groups | Sort-Object -Descending | Select-Object -First 1 

# Part 2 solution
$groups | sort-object -Descending | Select-Object -First 3 | Measure-Object -Sum


