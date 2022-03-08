# RiftGuildDemographicTracker
A script that outputs a text file of some pretty neat demographics.

This script is theoretically cross-platform, though it is entirely untested on non-Windows platforms.

There is no way with the /dumpguild command or with the Addon API to track Guild Member faction (Guardian/Defiant).

## Usage
1. To use this script, use /dumpguild while in-game to collect new data. This can be put into a macro.
- Verify that the output directory was to `C:\Users\YourUserNameHere\Documents\RIFT\guild.xml` 
- If it wasn't output to this directory, you will need to change the script to match your system's setup.

2. (Optional) Run the .bat file with the .ps1 file in the same directory. Note that this will require changing the PowerShell system policy. 
3. Notepad will open by default with the output. This output is stored at `C:\Users\YourUserNameHere\Documents\RIFT\guild.txt`.

The following output is taken raw from the \<A New Journey>@Deepwood guild sometime during the day of 3/3/2022.
This output includes (+0)'s for the event you have the previous day's output and wish to manually enter these values.
Perhaps in the future I'll include a way to take a previous output file to compare the numbers to.

````
```
Number of Chars in Guild
148

Number of Chars Online in the Last Week
77

Number of Chars Online in the Last Day
35
```
```
38 (+0) Mage | Mage | Magier
34 (+0) Rogue | Voleur | Schurke
31 (+0) Cleric | Clerc | Kleriker
27 (+0) Warrior | Guerrier | Krieger
18 (+0) Primalist | Primaliste | Primalist
```
```
#Lv70's: 7 (+0)

#Lv60-69's: 17 (+0)
Lv67 - 2
Lv66 - 4
Lv65 - 5
Lv64 - 2
Lv63 - 1
Lv61 - 2
Lv60 - 1

#Lv50-59's: 14 (+0)
Lv59 - 2
Lv58 - 1
Lv55 - 1
Lv54 - 2
Lv52 - 3
Lv51 - 1
Lv50 - 4

#Lv40-49's: 16 (+0)
Lv49 - 1
Lv48 - 1
Lv47 - 2
Lv45 - 1
Lv44 - 1
Lv43 - 2
Lv42 - 2
Lv41 - 2
Lv40 - 4

#Lv30-39's: 23 (+0)
Lv39 - 3
Lv38 - 2
Lv36 - 2
Lv35 - 2
Lv34 - 4
Lv33 - 1
Lv32 - 3
Lv31 - 4
Lv30 - 2

#Lv20-29's: 42 (+0)
Lv29 - 3
Lv28 - 7
Lv27 - 2
Lv26 - 4
Lv25 - 4
Lv24 - 4
Lv23 - 3
Lv22 - 10
Lv21 - 2
Lv20 - 3

#Lv10-19's: 21 (+0)
Lv18 - 4
Lv17 - 4
Lv16 - 5
Lv14 - 3
Lv13 - 1
Lv12 - 1
Lv11 - 1
Lv10 - 2

#Lv1-9's: 8 (+0)
Lv9 - 1
Lv7 - 1
Lv5 - 1
Lv4 - 1
Lv2 - 1
Lv1 - 3
```
````
  
# RiftOnlineNowCounter
This script is one I use to keep track of all the currently online characters, currently AFK characters, and to know what time each character logged off.

```
Note: All character names were manually anonymized to protect the guilty.

Name       IsOnline
----       --------
_          True
_          True
_          True

Name    AFK
----    ---
_       True

Name            LastLogOutTime
----            --------------
_               2/24/2022 5:19:26 PM
_               2/24/2022 5:10:10 PM
_               2/24/2022 5:00:00 PM
_               2/24/2022 4:14:25 PM
_               2/24/2022 3:59:06 PM
_               2/24/2022 3:38:04 PM
_               2/24/2022 3:32:43 PM
_               2/24/2022 2:37:18 PM
_               2/24/2022 1:45:54 PM
_               2/24/2022 1:36:01 PM
_               2/24/2022 1:34:45 PM
_               2/24/2022 12:53:12 PM
_               2/24/2022 12:52:20 PM
Note: This list goes on for *all* characters. Manually truncated for the sake of space.
```
