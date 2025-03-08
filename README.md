# Ada-MonsterGame
Fun learning project for Ada programming language enthusiasts to learn about OO in Ada and have fun by building a silly game

# Setup Instructions
Game utilizes [AdaCore tools](https://www.adacore.com/) to build Ada project files into exeuctables. Also, design documents and Wiki
pages that embed images use a light-weight drawing tool called [UMLet](https://umlet.com/).

The code was originally developed on Windows, but should/may work on Linux. The starting code uses ANSI control codes in a Windows
command prompt, and this may not work on Linux or may be disable in Windows. To enable ANSI support in Windows you need to modify the Windows
registry with:
```
[HKEY_CURRENT_USER\Console]
"VirtualTerminalLevel"=dword:00000001
```

## Ada tools
If you do not have an AdaCore professional subscription, you can use their latest tools for the general community. AdaCore
has moved their latest tools into the [Alire ecosystem](https://www.adacore.com/community). If you want to download an older version, AdaCore did a final release
of their [2021 versions](https://www.adacore.com/download/more) of the stand-alone tools.

You will need Ada tools to build the code.

## UMLet
Many design markdown files and embedded doc metadata in code files have images. These images are created 
using UMLet. If you plan to contribute and make updates to design material, UMLet needs to be [downloaded](https://umlet.com/changes.htm) and
put into a folder without spaces.

The second step is to tell the makefiles that use UMLet where it lives via setting a Windows environment variable:
```
UMLET_PATH=<PATH TO UMLET>

e.g., UMLET_PATH=c:\tools\UMLet
```

## Make
Conversion of UMLet files to image binaries is automated by a makefile.

GnuMake for Windows can be [downloaded](https://gnuwin32.sourceforge.net/packages/make.htm) and installed, our use make from another source if you have it. Make needs
to be readily available on a command prompt.
