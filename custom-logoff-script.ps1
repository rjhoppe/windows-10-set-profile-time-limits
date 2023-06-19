$Day = Get-Date -Format "dddd MM/dd/yyyy HH:mm K"

if ($Day -like "*Friday*" -or $Day -like "*Saturday*") {
   Write-Host "No action at this time because it is the weekend" -ForegroundColor Green
}
else {
   shutdown -r -f -t 03
}
