# This script keeps track of who is currently online, who is currently AFK, and a what time did everyone log out.
# Timestamp stuff is for compatibility with my own personal backup scripts. The script's functionality is not affected if it is left out.
param(
  [string]$Timestamp
)

Write-Output $Timestamp

$DSV = [System.IO.Path]::DirectorySeparatorChar # Just wanted a shorter name for use in Paths

# Gets the Guild data from the /dumpguild in-game command. Make it a macro to keep the guild.xml file updated easily :)
# On Windows, this path resolves to C:\Users\MyUsernameHere\Documents\RIFT\guild.xml by default.
$GuildXML = [xml](Get-Content -Path $("$([Environment]::GetFolderPath('MyDocuments'))$($DSV)RIFT$($DSV)guild$($Timestamp).xml"))

# Check this path as well if you're on a system different to Windows. This is the output file for the script.
# Feel free to 
$GuildTXT = $([Environment]::GetFolderPath("MyDocuments") + "$($DSV)RIFT$($DSV)guild$($Timestamp).txt")
Set-Content -Path $GuildTXT -Value ''

# Drills down in the XML to the Members node.
$GuildMembers = Select-XML -Xml $GuildXML -XPath '/Guild' `
  | Select -ExpandProperty Node `
  | Select -ExpandProperty Members `
  | Select -ExpandProperty Member


# This displays the chars that are currently online and not AFK
$GuildMembers `
| Where-Object { $_.IsOnline -eq 'True' -and $_.AFK -eq 'False' } `
| Sort-Object { Get-Date $_.LastLogOutTime } `
| Select-Object -Property Name,IsOnline `
| Format-Table `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays the chars that are currently AFK
$GuildMembers `
| Where-Object { $_.AFK -eq 'True' } `
| Sort-Object { Get-Date $_.LastLogOutTime } `
| Select-Object -Property Name,AFK `
| Format-Table `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays the chars that are no longer online, sorted by when they last logged out
$GuildMembers `
| Where-Object { $_.IsOnline -eq 'False' } `
| Sort-Object { $_.LastLogOutTime } `
| ForEach-Object { New-Object psobject -Property @{Name=$_.Name; LastLogOutTime=$(Get-Date $_.LastLogOutTime).ToLocalTime()} } `
| Select-Object -Property Name,LastLogOutTime `
| Sort-Object LastLogOutTime -Descending `
| Format-Table `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8


# Removes extra white space on each line
$GuildTXTContent = Get-Content -Path $GuildTXT # Saving to variable makes it so file isn't "open" and can be edited via Set
$GuildTXTContent `
| ForEach-Object { $_.Trim() } `
| Set-Content -Path $GuildTXT

# Removes the multiples of empty lines between each section
(Get-Content -Raw $GuildTXT).Replace("$([Environment]::NewLine)$([Environment]::NewLine)", "$([Environment]::NewLine)") `
| Set-Content $GuildTXT


# Comment me out if you're on a different system than Windows, or change the app that runs to a different text editor.
Write-Output 'File output done! Opening Notepad now.'
notepad $GuildTXT
