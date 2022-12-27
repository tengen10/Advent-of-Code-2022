# Day 25: Full of Hot Air

# Ref: Negative bases. balanced ternary. balanced quinary.

# Two steps to convert from decimal to balanced quinary
# 1) convert from decimal to quinary
# 2) convert from quinary to balanced quinary

# -2,-1,0,1,2


##
# Part 1
## 

#$data = get-content test.txt
$data = get-content input.txt

$SNAFU_to_base10list = new-object "system.collections.arraylist"

# Convert the SNAFU numbers to base 10

foreach ($num in $data) {

    $digits = $num.tochararray()
    [array]::Reverse($digits)    
    
    $value = 0

    for ($x=0 ; $x -lt $digits.Count; $x++) {

        switch ($digits[$x]) {

        '=' { [int]$digit = -2 ; break}
        '-' { [int]$digit = -1 ;break }
        default {[int]$digit =  [convert]::ToInt32($digits[$x],10) }
        }

        $value = $value + ([math]::Pow(5,$x) * $digit)
        #"digit is : {0}. value is : {1}" -f $digit,([math]::Pow(5,$x) * $digit)
    }
    "Base10 of {0} is: {1}" -f $num, $value

    [void]$SNAFU_to_base10list.Add($value)
}

[int64]$q = ($SNAFU_to_base10list | Measure-Object -sum).Sum

"SNAFU sum: {0}" -f $q 



#Convert the sum from Base 10 back to SNAFU
#############
#$q=1747
# 1=-0-2

$final = new-object "System.Collections.Stack"

for ($pos=0; $pos -lt 25 -and $q -gt 0; $pos++) {

    $remainder = $null

    $newq = [math]::divrem($q,5,[ref]$remainder)

    #"{0} / 5 = {1} mod {2}" -f $q, $newq, $remainder

    switch ($remainder) { 
        
        # remainders 4,5 are values -1,-2. Need to carry the one to the left.
        4 {[string]$digit = "-"; $newq+=1;break}
        3 {[string]$digit = "="; $newq+=1;break}
        2 {[string]$digit = "2";break}
        1 {[string]$digit = "1";break}
        0 {[string]$digit = "0";break}
    }

    
    #"{0}" -f $digit

    $stack.Push($digit)

    $q = $newq

}

"Base 10 to SNAFU: {0}" -f ($stack -join '')
$stack.Clear()




