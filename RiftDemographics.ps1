$DSV = [System.IO.Path]::DirectorySeparatorChar # Just wanted a shorter name for use in Paths

# Gets the Guild data from the /dumpguild in-game command. Make it a macro to keep the guild.xml file updated easily :)
# If you're on a system different to Windows, feel free to check whether the file outputs to your Documents folder\RIFT\guild.xml.
# On Windows, this path resolves to C:\Users\MyUsernameHere\Documents\RIFT\guild.xml by default.
$GuildXML = [xml](Get-Content -Path $("$([Environment]::GetFolderPath('MyDocuments'))$($DSV)RIFT$($DSV)guild.xml"))

# Check this path as well if you're on a system different to Windows. This is the output file for the script.
$GuildTXT = $([Environment]::GetFolderPath("MyDocuments") + "$($DSV)RIFT$($DSV)guild.txt")
Set-Content -Path $GuildTXT -Value ''

# Drills down in the XML to the Members node.
$GuildMembers = Select-XML -Xml $GuildXML -XPath '/Guild' `
  | Select -ExpandProperty Node `
  | Select -ExpandProperty Members `
  | Select -ExpandProperty Member
  
# Code Formatting
'```' | Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays the total number of chars in the guild.
"Number of Chars in Guild" | Out-File -Append -FilePath $GuildTXT -Encoding utf8
$GuildMembers.Count `
| Group-Object `
| Select-Object -Property Name `
| Format-Table -HideTableHeaders `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays the number of chars online in the last week.
"Number of Chars Online in the Last Week" | Out-File -Append -FilePath $GuildTXT -Encoding utf8
$GuildMembers `
| Where-Object { $(Get-Date $_.LastLogOutTime) -gt ([DateTime]::UtcNow).AddDays(-7) } `
| Sort-Object { Get-Date $_.LastLogOutTime } `
| Group-Object `
| Select-Object -Property Count `
| Sort-Object Count -Descending `
| Format-Table -HideTableHeaders `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays the number of chars online sometime today.
"Number of Chars Online in the Last Day" | Out-File -Append -FilePath $GuildTXT -Encoding utf8
$GuildMembers `
| Where-Object { $(Get-Date $_.LastLogOutTime) -gt ([DateTime]::UtcNow).AddDays(-1) -or $_.IsOnline -eq 'True' } `
| Sort-Object { Get-Date $_.LastLogOutTime } `
| Group-Object `
| Select-Object -Property Count `
| Sort-Object Count -Descending `
| Format-Table -HideTableHeaders `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# Code Formatting
'```' | Out-File -Append -FilePath $GuildTXT -Encoding utf8

###

# Code Formatting
'```' | Out-File -Append -FilePath $GuildTXT -Encoding utf8
# This displays the number of members of each calling.
$GuildMembers `
| Group-Object Calling `
| Select-Object -Property Count,Name `
| Sort-Object Count -Descending `
| Format-Table -HideTableHeaders `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8
# Code Formatting
'```' | Out-File -Append -FilePath $GuildTXT -Encoding utf8

###

# Code Formatting
'```' | Out-File -Append -FilePath $GuildTXT -Encoding utf8
for($i = 7; $i -ge 0; $i = $i - 1) {
    if($i -eq 0) {
        # Get number of chars from Lv1 to Lv9
        "#Lv1-9's: " | Out-File -Append -FilePath $GuildTXT -Encoding utf8 -NoNewline
        $GuildMembers `
        | Where-Object { [int]$($_.Level) -ge 1 -and [int]$($_.Level) -le 9 } `
        | Measure-Object `
        | Select-Object -Property Count `
        | ForEach-Object { $_.Count.ToString() + ' (+0)' } `
        | Out-File -Append -FilePath $GuildTXT -Encoding utf8
        # Get number of each level of chars from Lv1 to 9
        $GuildMembers `
        | Where-Object { [int]$($_.Level) -ge 1 -and [int]$($_.Level) -le 9 } `
        | Group-Object -Property Level `
        | Select-Object -Property Name,Count `
        | Sort-Object Name -Descending `
        | Format-Table -HideTableHeaders `
        @{ Label='Name'; Expression={'Lv' + $_.Name}; Alignment='Left'; }, Count `
        | Write-Output `
        | Out-File -Append -FilePath $GuildTXT -Encoding utf8
    } elseif ($i -lt 7) {
        # Get number of LvI0-I9's (10-69)
        "#Lv$($i)0-$($i)9's: " | Out-File -Append -FilePath $GuildTXT -Encoding utf8 -NoNewline
        $GuildMembers `
        | Where-Object { [int]$($_.Level) -ge ($i * 10) -and [int]$($_.Level) -le ($i * 10 + 9) } `
        | Measure-Object `
        | Select-Object -Property Count `
        | ForEach-Object { $_.Count.ToString() + ' (+0)' } `
        | Out-File -Append -FilePath $GuildTXT -Encoding utf8
        # Get number of each level of LvI0-I9's (10-69)
        $GuildMembers `
        | Where-Object { [int]$($_.Level) -ge ($i * 10) -and [int]$($_.Level) -le ($i * 10 + 9) } `
        | Group-Object -Property Level `
        | Select-Object -Property Name,Count `
        | Sort-Object Name -Descending `
        | Format-Table -HideTableHeaders `
        @{ Label='Name'; Expression={'Lv' + $_.Name}; Alignment='Left'; }, Count `
        | Write-Output `
        | Out-File -Append -FilePath $GuildTXT -Encoding utf8

    } elseif ($i -eq 7) {    
        # Get number of Lv70's
        "#Lv70's: " | Out-File -Append -FilePath $GuildTXT -Encoding utf8 -NoNewline
        $GuildMembers `
        | Where-Object { [int]$($_.Level) -eq 70 } `
        | Measure-Object `
        | Select-Object -Property Count `
        | ForEach-Object { $_.Count.ToString() + ' (+0)' } `
        | Out-File -Append -FilePath $GuildTXT -Encoding utf8
        # New line
        "$([Environment]::NewLine)" | Out-File -Append -FilePath $GuildTXT -Encoding utf8
    }
}
# Code Formatting
'```' | Out-File -Append -FilePath $GuildTXT -Encoding utf8

###

# Removes extra white space on each line
$GuildTXTContent = Get-Content -Path $GuildTXT # Saving to variable makes it so file isn't "open" and can be edited via Set
$GuildTXTContent `
| ForEach-Object { $_.Trim() } `
| Set-Content -Path $GuildTXT

# Removes the multiples of empty lines between each section
(Get-Content -Raw $GuildTXT).Replace("$([Environment]::NewLine)$([Environment]::NewLine)", "$([Environment]::NewLine)") `
| Set-Content $GuildTXT

# Removes the empty lines before each end of code formatting
(Get-Content -Raw $GuildTXT).Replace("$([Environment]::NewLine)$([Environment]::NewLine)"+'```', "$([Environment]::NewLine)"+'```') `
| Set-Content $GuildTXT

# Adds a +0 counter placeholder next to each class name. This can be manually edited to show growth.
(Get-Content -Raw $GuildTXT).Replace('Mage', '(+0) Mage').Replace('Rogue', '(+0) Rogue').Replace('Cleric', '(+0) Cleric').Replace('Warrior', '(+0) Warrior').Replace('Primalist', '(+0) Primalist') `
| Set-Content $GuildTXT

# Replaces the class names with their translations.
(Get-Content -Raw $GuildTXT).Replace('Mage', 'Mage | Mage | Magier').Replace('Rogue', 'Rogue | Voleur | Schurke').Replace('Cleric', 'Cleric | Clerc | Kleriker').Replace('Warrior', 'Warrior | Guerrier | Krieger').Replace('Primalist', 'Primalist | Primaliste | Primalist') `
| Set-Content $GuildTXT

# Remove the 3 and 2 spaces in a row and make it dashes instead
$GuildTXTContent = Get-Content -Path $GuildTXT # Saving to variable makes it so file isn't "open" and can be edited via Set
$AllowReplacing = $false # Only allow replacing after we get down to the unique char level groupings
$GuildTXTContent `
| ForEach-Object { 
    if($AllowReplacing){
        $_.ToString().Replace('   ', ' ').Replace('  ', " - ").Replace('  ', ' ') # Bug Note: Expression *might* not work for numbers >= 100.
    } else {
      $_
    }
    # Start with the lines under the start of the level ranges
    if($_.StartsWith("#Lv60-69")) {
        $AllowReplacing = $true
    }
} `
| Set-Content -Path $GuildTXT

# Comment me out if you're on a different system than Windows, or change the app that runs to a different text editor.
Write-Output 'File output done! Opening Notepad now.'
notepad $GuildTXT
