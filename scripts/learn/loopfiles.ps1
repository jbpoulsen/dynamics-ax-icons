param ([Parameter(Mandatory=$true)][string]$folder)

write-output "Looping files in " $folder

Get-ChildItem $folder | 
Foreach-Object {
    $content = Get-Content $_.FullName
    
    write-output $_.Name
}
