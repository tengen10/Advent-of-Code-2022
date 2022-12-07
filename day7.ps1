# Day 7: No Space Left On Device 

# /dir1/dir2/dir3
# /dir1/dir2/dir1

# Decided to use the file system 
# Interpreted the input as commands to create the files and folders
# Then used get-childitem and measure-object

function New-EmptyFile
{
   param( [string]$FilePath,[double]$Size )

   $file = [System.IO.File]::Create($FilePath)
   $file.SetLength($Size)
   $file.Close()
}

$data = Get-Content input.txt
$data = $data -replace '/', '.'

$basepath = Get-Location

Set-Location -Path .\root

for ($x=0; $x-lt $data.Length; $x++) {

    $line = $data[$x] -split " "

    if ($line[0] -eq '$') {
        if ($line[1] -eq 'cd') {
            if ($line[2] -ne '..') { 
                new-item -ItemType Directory -Name $line[2]
                Set-Location $line[2] 
                } 
                elseif ($line[2] -eq '..') {
                    set-location $line[2]
                }
             }
         }


      if ($line[0] -ne '$') { 
          $line -join ","
          if ($line[0] -eq 'dir') { 
            "it is a dir" 
          } else {
            $fullpath = $(get-location).Path + "\" + $line[1]
            $filesize = $line[0]
            New-EmptyFile -FilePath $fullpath -Size $filesize
          }
     }      
} 

$basepath | Set-Location 
$sum =0
$folderlist = get-childitem -Path .\root -Directory -recurse | Select-Object -Property Fullname

foreach ($folder in $folderlist) {
    $foldersize = (get-childitem -Path $folder.FullName -Recurse | Measure-Object -Property length -sum).Sum

    if ($foldersize -le 100000) {
        "{0}:{1}" -f $foldersize, $folder.fullname
        $sum += $foldersize
    }
}

"Total: {0}" -f $sum


##
# Part 2
##

$spaceused = (get-childitem -path .\root\* -Recurse | Measure-Object -Property length -sum).sum

$spaceavailable = 70000000
$spaceneeded = 30000000
$freeup = $spaceneeded - ($spaceavailable - $spaceused)

$currentlow = 99999999999

$basepath | Set-Location 
$folderlist = get-childitem -Path .\root -Directory -recurse | Select-Object -Property Fullname

foreach ($folder in $folderlist) {
    $foldersize = (get-childitem -Path $folder.FullName -Recurse | Measure-Object -Property length -sum).Sum
    
    if ($foldersize -ge $freeup) {
        if ($foldersize -lt $currentlow) { $currentlow = $foldersize; "current low {0}:{1}" -f $currentlow, $folder.fullname}  
    }
}


