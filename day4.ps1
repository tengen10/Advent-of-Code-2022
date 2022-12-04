# Day 4: Camp Cleanup


## Part 1

#$list = get-content .\test.txt
$list = get-content .\input.txt

$matching = 0

foreach ($line in $list) {

    $pairs = $line -split ',' 

    [int[]]$set1 = invoke-expression $($pairs[0].Replace("-",".."))
    [int[]]$set2 = invoke-expression $($pairs[1].Replace("-",".."))
    
    #"{0}:{1}" -f [string]$($set1 -join ''),[string]$($set2 -join '')

    $diff = Compare-Object $set1 $set2 -IncludeEqual -ExcludeDifferent
    #"{0}:{1}:{2}" -f $set1.count,$set2.count,$diff.inputobject.count
    
    if ($diff.inputobject.count -in ($set1.Count,$set2.count)) {
        "found: {0}:{1}" -f [string]$($set1 -join ''),[string]$($set2 -join '')
        $matching +=1

    }    
}
"Matching pairs: {0}" -f $matching



## part 2

$matching = 0
foreach ($line in $list) {

    $pairs = $line -split ',' 

    [int[]]$set1 = invoke-expression $($pairs[0].Replace("-",".."))
    [int[]]$set2 = invoke-expression $($pairs[1].Replace("-",".."))

    #"{0}:{1}" -f [string]$($set1 -join ','),[string]$($set2 -join ',')

    $diff = Compare-Object $set1 $set2 -IncludeEqual -ExcludeDifferent 
    
    if ($diff.inputobject.count -ge 1) {
        $matching +=1
    }    
}

"Matching pairs: {0}" -f $matching


