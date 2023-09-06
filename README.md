# DNXDOScript ![image](https://user-images.githubusercontent.com/3720302/138952395-1b97a5be-0f24-4228-be5e-b8d8b80d37a7.png)

Debloat and Optimization Script for machines running Windows 10

Download package
[DNXDOScript.zip](https://github.com/Deen0X/DNXDOScript/releases

you can check for updates here:

https://github.com/Deen0X/DNXDOScript
https://t.me/PCMasterRacePortable/673587    (Spanish spoken Group)

This Script help to gain performance on your system, in two main ways:
- Original project was based on W4RH4WK work, but starting with 2.1.8 , i write my own code to implement optimizations on the code, improving performance to run the main script.
- The main goal of this script is to create a way to allow users to include their own subscripts, without need to modifying the original script. Simply add your Powersheel Script (ps1), Command Batch file (cmd, bat) or reg files on Scripts\Enabled or Utils\Enabled folders
- This script include many tweaks for improve performance on windows, focused on setup a gaming pc, or trying to get usable old machines such tablets, netbooks, old pcs, etc, that don´t have so much resources but can install windows 10.
- Many scripts from previous versions was merged in a main script (cmd, bat, reg, ps1) for improve performance when running from main script. You can check them and modify if you need. I added comments to each section for allow to easy understand what is doing these files.

As extra, there are some Utils included with the package that may be interesting for users to run on their system

# This script will modify your windows 10 installation

![image](https://user-images.githubusercontent.com/3720302/138956331-15ae85fe-4dcc-421d-8e2d-dbe241e0f224.png)


# How it works?

You must run as administrator (right click on DNSDOScript.cmd file, run as administrator)

The main script will scan two main folders,  looking for files (subscripts) that will execute.

These files can be .cmd, .bat, .reg, .ps1, etc, anything that can be launched from the main script (cmd). Take note that these scripts will be executed in alphabetical order, so if you want to specific order on script execution, you must rename scripts in the proper way to ensure their execution. I suggest to add some number before the name, such "000_name of script.cmd" , "001_name of powershell script.ps1", etc.

There are two main folders:
- Scripts: This contain all scripts that will be launched by the main script
- Utils: This contain extra scripts considered as Util/Tool, because will not impact directly on the performance and most of them are accessory to the installation. You can install your own extra software using some cmd/ps1 script.

Inside each main folder, there are two subfolders
- Enabled: Scripts that will be executed are included on this folder
- Disabled: If you don´t want to run some script, instead of editing or deleting, move it from Enabled folder to this one. The main script will not execute any of the scripts on this folder.

# Main Screen Execution

The main screen of the Script will show the subscripts launched, and a little info about the kind of subscript (the first letter of the extension, to know if a Reg file, Cmd, Bat, Ps1, etc correspond to this script)

![image](https://user-images.githubusercontent.com/3720302/138957308-d7f77f5d-b6b5-4ed6-be6d-03c4eda83144.png)

The "OK" text simply indicate that the script finalized. This will not be consider info about the result of the SubScript itself.
The "." indicate that the subscript is not a file. Is part of the main script.

# Window for SubScripts

![image](https://user-images.githubusercontent.com/3720302/138958783-18310202-6516-4f98-9f8d-04f97e2942de.png)

Note: On some windows subscripts may appear some errors/red text/etc. Don't worry, this is normal.

# Note about Microsoft Store SubScript

This script will install Microsoft Store and related software on the system, and is based on the
script "LTSC-Add-MicrosoftStore" by kkkgo.
https://github.com/kkkgo/LTSC-Add-MicrosoftStore

My script simply download their package (https://github.com/lixuy/LTSC-Add-MicrosoftStore/archive/2019.zip) from
their repository, unpack and copy on the main_script_folder\Extras, and process it (modify kkkgo script for remove pauses, and run it)

![image](https://user-images.githubusercontent.com/3720302/138957688-73f09a62-19f7-4852-8ea4-67346fb3bfbb.png)

Take note that first time you run this script, most probablyl will need to download the file, so this may take few minutes because the tool for download from command line, maybe not fast as internet browser.

If the download fails, simply download the file and unpack on the following path:
DNXDOScript_path\Extras\MicrosoftStore\


# Windows Start Menu Entry

The script adds a new Windows Start Menu entry, for launch again the script when you want.

![image](https://user-images.githubusercontent.com/3720302/138959091-751cf1b2-fa9d-4dba-b6b9-1681313820f4.png)


# Note about virtual memory

This script set the virtual memory of the device based on the installed RAM.
Thinking on low powered devices, where usually don´t have so much RAM installed, is not the best to set a big ammount of virtual memory, because the system may get a downgrade in terms of performance (more virtual memory on low storage, then become the system slow and unresponsive), for this reason the script try to set a reasonable ammount of virtual memory depending on the RAM installed.

There are some software or games that can´t run with low ram resources, such Yuzu, that need near to 4 or 5GB of virtual memory to run. If the case, then set manually the virual memory on the system, to allow these programs to run.


# Whats new (starting from 2.1.8)

- I convert the option "Create restore point" as a script. Starting from 2.1.8 this script is disabled. If you want to create a restore point, you must move from "Disabled" to "Enabled" Folder, and ensure that the name of the script will be at the top of the list (alphabetic ordered). This way, the script will launch before any other in the directory.

Hope you found useful this script.

Deen0X
