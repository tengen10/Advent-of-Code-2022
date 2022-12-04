# Day 3 : Rucksack Reorganization


$list = get-content .\input.txt

$lower = 'abcdefghijklmnopqrstuvwxyz'
$upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'


## part 1
$total = 0

foreach ($line in $list) {

$mid = $line.Length/2

$s1 = $line.Substring(0,$mid).tochararray()  | Sort-Object -Unique
$s2 = $line.Substring($mid,$mid).ToCharArray() | Sort-Object -Unique

$found = $false
for ($x = 0; $x -lt $mid -and -not($found); $x++) {
    for ($y = 0; $y -lt $mid -and -not($found); $y++) {

        if ($s1[$x] -ceq $s2[$y]) {  
            $found = $true; 
            if ($lower.IndexOf($s2[$y]) -ne -1) {
            $p1 = $lower.IndexOf($s2[$y]) + 1;
            } else {
            $p1 = $upper.IndexOf($s2[$y]) + 27; 
            }

            "found: {0} : {1}" -f $s2[$y],$p1 
         }
    
    }
}

$total += $p1

}

"total: {0}" -f $total


## part 2

$total = 0

for ($r = 0; $r -lt $list.Count; $r += 3) {

$s1 = $list[$r].tochararray()  | Sort-Object -Unique
$s2 = $list[$r+1].tochararray()  | Sort-Object -Unique
$s3 = $list[$r+2].tochararray()  | Sort-Object -Unique


$found = $false
for ($x = 0; $x -lt $s1.Length -and -not($found); $x++) {
    for ($y = 0; $y -lt $s2.Length -and -not($found); $y++) {
        for ($z = 0; $z -lt $s3.Length -and -not($found); $z++) {


        if ($s1[$x] -ceq $s2[$y] -and $s2[$y] -ceq $s3[$z]) {  
            $found = $true; 
            #"{0}:{1}:{2}" -f $s1[$x],$s2[$y],$s3[$z]
            if ($lower.IndexOf($s3[$z]) -ne -1) {
            $p1 = $lower.IndexOf($s3[$z]) + 1;
            } else {
            $p1 = $upper.IndexOf($s3[$z]) + 27; 
            }

            "found: {0} : {1}" -f $s3[$z],$p1 
         }
    }
    }
}

$total += $p1

}

"total: {0}" -f $total





$enc        = [System.Text.Encoding]::UTF8
$byte_array = $enc.GetBytes('a')
write-host    $byte_array
$text       = $enc.GetString($byte_array)

$s1 -join '' | format-hex -OutVariable check

$check[0].Bytes

'A' -clt 'a'

Get-Content .\test.txt | Measure-Object -Character

# Upper and lowercase
$tally = ((65..90) + (97..122) | % {[char]$_}) -join ''

$upper = [char[]]([char]'A'..[char]'Z') 
$count = [int[]]::new($upper.Length)

$count -join ' ' 

[array]::indexof($count,12)

$count[25]
$count.GetUpperBound(0)


$count | Measure-Object -Maximum

'AAABBCCCCCCCZZZZZZZZZZZZ'.ToCharArray() | %{ $i = $upper.IndexOf($_); $count[$i] += 1}



 $data = @(
       [pscustomobject]@{ID=8;Note='B#'}
       [pscustomobject]@{ID=9; Note='C'}
   )

   $data.Where({$_.Note -like '*C*'})



# Serialize and Deserialize data using BinaryFormatter
$ms = New-Object System.IO.MemoryStream
$bf = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
$bf.Serialize($ms, $upper)
$ms.Position = 0

#Deep copied data
$newupper = $bf.Deserialize($ms)
$ms.Close()

#fill array
$newupper = @(255) * $newupper.Count

$newupper = @(1) * $newupper.Count


[int[]]::new(4)



[char[]]('A'[0]..'Z'[0])
