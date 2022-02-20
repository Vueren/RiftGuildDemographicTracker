# RiftGuildDemographicTracker
A script that outputs a text file of some pretty neat demographics.

This script is theoretically cross-platform, though it is entirely untested on non-Windows platforms.

There is no way with the /dumpguild command or with the Addon API to track Guild Member faction (Guardian/Defiant).

When outputting demographics to a platform such as Discord, remember to use Code Script formatting. That is generally 3 backticks, followed by the text, followed by another 3 backticks. This ensures that columns retain their formatting.

\`\`\`

Ctrl + V here

\`\`\`

## Usage
1. To use this script, use /dumpguild while in-game to collect new data. This can be put into a macro.
- Verify that the output directory was to `C:\Users\YourUserNameHere\Documents\RIFT\guild.xml` 
- If it wasn't output to this directory, you will need to change the script to match your system's setup.

2. Run the .bat file with the .ps1 file in the same directory, or run the PowerShell file directly if your system policy supports it. 
3. Notepad will open by default with the output. This output is stored at `C:\Users\YourUserNameHere\Documents\RIFT\guild.txt`.

The following output is taken from the <A New Journey>@Deepwood guild sometime during the day of 2/19/2022.
As you can see, it looks pretty raw. Generally a little bit of manual formatting is recommended from here, though it is not required.

```

Number of Chars in Guild
------------------------
113

Number of Chars Online In The Last Week
---------------------------------------
87

Number of Chars Online In The Last Day
--------------------------------------
53

Calling   Count
-------   -----
Mage      30
Rogue     30
Cleric    22
Warrior   19
Primalist 12

Lvl Range Count
--------- -----
70        5
60        10
50        8
40        13
30        18
20        39
10        15
1         5

Lvl Count
--- -----
70  5
66  2
65  4
64  1
63  1
61  1
60  1
58  1
54  1
52  1
51  2
50  3
49  1
48  1
47  2
45  3
43  2
42  2
41  1
40  1
39  2
38  2
36  1
35  1
34  3
33  3
32  3
31  2
30  1
29  2
28  8
27  1
26  3
25  3
24  2
23  2
22  8
21  5
20  5
18  3
17  4
16  2
13  2
12  2
11  1
10  1
5   1
4   1
1   3
```
  
