# RiftGuildDemographicTracker
A script that outputs a text file of some pretty neat demographics.

This script is theoretically cross-platform, though it is entirely untested on non-Windows platforms.

There is no way with the /dumpguild command or with the Addon API to track Guild Member faction (Guardian/Defiant).

## Usage
1. To use this script, use /dumpguild while in-game to collect new data. This can be put into a macro.
- Verify that the output directory was to `C:\Users\YourUserNameHere\Documents\RIFT\guild.xml` 
- If it wasn't output to this directory, you will need to change the script to match your system's setup.

2. Run the .bat file with the .ps1 file in the same directory, or run the PowerShell file directly if your system policy supports it. 
3. Notepad will open by default with the output. This output is stored at `C:\Users\YourUserNameHere\Documents\RIFT\guild.txt`.

The following output is taken raw from the <A New Journey>@Deepwood guild sometime during the day of 2/19/2022.
As you can see, it looks pretty raw. Generally a little bit of manual formatting is recommended from here, though it is not required.

```

Number of Chars in Guild
------------------------
126

Number of Chars Online In The Last Week
---------------------------------------
88

Number of Chars Online In The Last Day
--------------------------------------
33

Calling   Count
-------   -----
Mage      32
Rogue     31
Cleric    26
Warrior   23
Primalist 14

Lvl Range Count
--------- -----
70        6
60        11
50        11
40        15
30        21
20        39
10        16
1         7

Lvl Count
--- -----
Lv70 - 6
Lv66 - 2
Lv65 - 5
Lv64 - 1
Lv61 - 1
Lv60 - 2
Lv58 - 1
Lv57 - 1
Lv56 - 1
Lv53 - 2
Lv52 - 2
Lv51 - 2
Lv50 - 2
Lv49 - 2
Lv47 - 1
Lv46 - 2
Lv45 - 2
Lv44 - 1
Lv43 - 1
Lv42 - 2
Lv41 - 3
Lv40 - 1
Lv39 - 3
Lv38 - 3
Lv37 - 1
Lv36 - 1
Lv35 - 1
Lv34 - 5
Lv33 - 1
Lv32 - 2
Lv31 - 3
Lv30 - 1
Lv29 - 2
Lv28 - 8
Lv26 - 2
Lv25 - 5
Lv24 - 2
Lv23 - 2
Lv22 - 10
Lv21 - 3
Lv20 - 5
Lv18 - 3
Lv17 - 3
Lv16 - 3
Lv14 - 1
Lv13 - 2
Lv11 - 3
Lv10 - 1
Lv9 - 1
Lv7 - 1
Lv5 - 1
Lv4 - 1
Lv2 - 1
Lv1 - 2
```
  
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
