DAx14000, DAx22000 Windows 7/8/10 64-bit GUI/SDK description (05-11-17)

Note: See main directory "dax22000_user_sw" for USB driver information.


See file descriptions below. Please refer all questions to: 
techsupport@chase-scientific.com.


-----------   D I R E C T O R I E S / F I L E S  ----------------
BASE_DIR
|
| README_FIRST.txt         // This file.

| dax22000_GUI_64.exe      // Graphical program for exercising DAx22000 (calls ftd2xx.dll)

| test_dll.cpp             // Example C/C++ source file for accessing API DLL below.
| test_dll.exe             // Compiled with GCC 

| dax22000_lib_DLL64.dll       // DAx22000 API DLL (32-bit); Also calls ftd2xx.dll.
| dax22000_lib_DLL64.h         // Header file to DLL used with example source.

| ftd2xx64.dll               // FTDI USB driver for 32-bit Windows XP/7
                              (also works on 64-bit system)

| dll_support_files
| | dax22000_lib_DLL64.lib
| | dax22000_lib_DLL64.def
| | dax22000_lib_DLL64.exp
| | disclaimer.txt
                              
 --------------   E N D    ----------------

