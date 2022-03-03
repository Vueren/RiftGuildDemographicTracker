$DSV = [System.IO.Path]::DirectorySeparatorChar # Just wanted a shorter name for use in Paths

# Gets the Guild data from the /dumpguild in-game command. Make it a macro to keep the guild.xml file updated easily :)
# If you're on a system different to Windows, feel free to check whether the file outputs to your Documents folder\RIFT\guild.xml.
# On Windows, this path resolves to C:\Users\MyUsernameHere\Documents\RIFT\guild.xml by default.
$GuildXML = [xml](Get-Content -Path $("$([Environment]::GetFolderPath('MyDocuments'))$($DSV)RIFT$($DSV)guild.xml"))

# Check this path as well if you're on a system different to Windows. This is the output file for the script.
$GuildTXT = $([Environment]::GetFolderPath("MyDocuments") + "$($DSV)RIFT$($DSV)guild.txt")
Set-Content -Path $GuildTXT -Value ''

# This will be an ArrayList of ArrayLists. The program currently segments each range out by 10's.
$levelRanges = New-Object System.Collections.ArrayList
# Don't start at 0 or null reference for levels 1-9.
$currentRange = -1

# Drills down in the XML to the Members node.
$GuildMembers = Select-XML -Xml $GuildXML -XPath '/Guild' `
  | Select -ExpandProperty Node `
  | Select -ExpandProperty Members `
  | Select -ExpandProperty Member

# Sort by level and fill out the levelRanges array
$GuildMembers `
| Sort-Object { [int]$_.Level } `
| ForEach-Object {
  $newCurrentRange = ([Math]::Floor($_.Level / 10)) % 10 # Gets the 10s digit
  if($newCurrentRange -ne $currentRange) { # If we made it to a new 10s digit in our sorted list
      # make sure we aren't skipping 10s digits
      # Example: if we don't have any Lv20's, we'll need to skip that range.
      # Display is dependent on index, so add an empty list anyway to sync it up.
      while($levelRanges.Count -le $newCurrentRange) {
        $levelRanges.Add($(New-Object System.Collections.ArrayList)) | Out-Null
      }
      $currentRange = $newCurrentRange # make the new 10s digit our current digit
  }
  # Add the level to the most recently added level range
  $levelRanges[$levelRanges.Count - 1].Add($_.Level) | Out-Null
}

# This retrieves the levelRange and pairs levels with it via a key-value pairing instead of an index-value pairing. 
# - The key has the correct name for the level range, being the bottom level of the range. 
# Can manipulate the text file output to manually add " - 69" to the end easily if desired.
$levelRangesHash = @{}
for( $i = $levelRanges.Count - 1; $i -ge 0; $i-- ) {
  if($i -eq 0) {
    $levelRange = 1
  } else {
    $levelRange = $i * 10
  }
  $levelRangesHash.Add($levelRange, $levelRanges[$i].Count)
}

# This displays the total number of chars in the guild.
$GuildMembers.Count `
| Group-Object `
| Select-Object -Property Name `
| Format-Table `
@{ Label='Number of Chars in Guild'; Expression='Name'; Alignment='Left'; } `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays the number of chars online in the last week.
$GuildMembers `
| Where-Object { $(Get-Date $_.LastLogOutTime) -gt ([DateTime]::UtcNow).AddDays(-7) } `
| Sort-Object { Get-Date $_.LastLogOutTime } `
| Group-Object `
| Select-Object -Property Name,Count `
| Sort-Object Count -Descending `
| Format-Table `
@{ Label='Number of Chars Online In The Last Week'; Expression='Count'; Alignment='Left'; } `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays the number of chars online sometime today.
$GuildMembers `
| Where-Object { $(Get-Date $_.LastLogOutTime) -gt ([DateTime]::UtcNow).AddDays(-1) -or $_.IsOnline -eq 'True' } `
| Sort-Object { Get-Date $_.LastLogOutTime } `
| Group-Object `
| Select-Object -Property Name,Count `
| Sort-Object Count -Descending `
| Format-Table `
@{ Label='Number of Chars Online In The Last Day'; Expression='Count'; Alignment='Left'; } `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays the number of members of each calling.
$GuildMembers `
| Group-Object Calling `
| Select-Object -Property Name,Count `
| Sort-Object Count -Descending `
| Format-Table `
@{ Label='Calling'; Expression='Name'; Alignment='Left'; }, `
@{ Label='Count'; Expression='Count'; Alignment='Left'; } `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays each level range and the number of chars that fall within it.
$levelRangesHash.GetEnumerator() `
| Sort-Object -Property Name -Descending `
| Format-Table `
@{Label='Lvl Range'; Expression='Name'; Alignment='Left';}, `
@{Label='Count'; Expression='Value'; Alignment='Left';} `
| Write-Output `
| Out-File -Append -FilePath $GuildTXT -Encoding utf8

# This displays the number of chars at each *unique* level. We might have 5 Lv70's for example.
$levelRanges `
| ForEach-Object { $_ | Group-Object } `
| Select-Object -Property Name,Count `
| Sort-Object { [int]$_.Name } -Descending `
| Format-Table `
@{ Label='Lvl'; Expression='Name'; Alignment='Left'; }, `
@{ Label='Count'; Expression='Count'; Alignment='Left'; } `
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

# Remove the 3 and 2 spaces in a row and make it dashes instead
$GuildTXTContent = Get-Content -Path $GuildTXT # Saving to variable makes it so file isn't "open" and can be edited via Set
$AllowReplacing = $false # Only allow replacing after we get down to the unique char level groupings
$GuildTXTContent `
| ForEach-Object { 
    if($AllowReplacing){
        if(-not $_.Equals("")) {
            'Lv' + $_.ToString().Replace("   ", " - ").Replace("  ", " - ") 
        }
    } else {
      $_
    }
    # The line under Lvl Count
    if($_.Equals("--- -----")) {
        $AllowReplacing = $true
    }
} `
| Set-Content -Path $GuildTXT

# Comment me out if you're on a different system than Windows, or change the app that runs to a different text editor.
Write-Output 'File output done! Opening Notepad now.'
notepad $GuildTXT
