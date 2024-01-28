::Package Creator (C) Joshua Cline - All rights reserved
@ECHO OFF&&SETLOCAL ENABLEDELAYEDEXPANSION&&CD /D "%~DP0"&&Reg.exe query "HKU\S-1-5-19\Environment">NUL
IF NOT "%ERRORLEVEL%" EQU "0" ECHO Right-Click ^& Run As Administrator&&PAUSE&&EXIT 0
SET "##=[94m"&&SET "#$=[97m"&&SET "#@=[96m"&&FOR /F "TOKENS=*" %%a in ('ECHO %CD%') DO (SET "PROG_SOURCE=%%a")
SET "CAPS_SET=PROG_SOURCE"&&SET "CAPS_VAR=%PROG_SOURCE%"&&CALL:CAPS_SET
SET "CHAR_STR=%PROG_SOURCE%"&&SET "CHAR_CHK= "&&CALL:CHAR_CHK
IF DEFINED CHAR_FLG ECHO Remove the space from the path\folder name, then launch again&&PAUSE&&EXIT 0
TITLE Download more scripted utilities from github.com/joshuacline
:PACKAGE_CREATOR
CLS&&FOR %%a in (PACK_XLVL) DO (IF NOT DEFINED %%a SET "%%a=FAST")
FOR %%a in (MAKER_SLOT PAK_XXX) DO (IF NOT DEFINED %%a SET "%%a=1")
SET "MAKER_FOLDER=%PROG_SOURCE%\Project%MAKER_SLOT%"
CLS&&CALL:SCRATCH_PACK_DELETE&&CALL:PAD_LINE&&ECHO                             Package Creator&&CALL:PAD_LINE
FOR %%a in (PackName PackType PackTag PackDesc REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=NULL")
IF EXIST "%MAKER_FOLDER%\PACKAGE.MAN" COPY /Y "%MAKER_FOLDER%\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
SET "PACK_CHK="&&IF NOT "%REG_KEY%"=="NULL" IF NOT "%REG_VAL%"=="NULL" IF NOT "%RUN_MOD%"=="NULL" IF NOT "%REG_DAT%"=="NULL" SET "PACK_CHK=1"
IF DEFINED PACK_CHK FOR %%a in (REG_KEY REG_VAL RUN_MOD REG_DAT) DO (IF NOT DEFINED %%a SET "PACK_CHK=")
IF "%PACK_CHK%"=="1" (SET "PACK_COND=ENABLED") ELSE (SET "PACK_COND=DISABLED")
IF EXIST "$PAK" DEL /F "$PAK">NUL
IF "%PACK_COND%"=="ENABLED" ECHO  [Name[%#@%%PackName%%#$%] [Type[%#@%%PackType%%#$%] [Tag[%#@%%PackTag%%#$%] [X-Lvl[%#@%%PACK_XLVL%%#$%] [PMT[%#@%%PACK_COND%%#$%]&&CALL:PAD_LINE
IF "%PACK_COND%"=="DISABLED" ECHO  [Name[%#@%%PackName%%#$%] [Type[%#@%%PackType%%#$%] [Tag[%#@%%PackTag%%#$%] [X-Lvl[%#@%%PACK_XLVL%%#$%]&&CALL:PAD_LINE
ECHO  [Desc]: %#@%%PackDesc%%#$%&&CALL:PAD_LINE
IF "%PACK_COND%"=="ENABLED" ECHO  [Permit IF]: [%#@%%REG_KEY% %REG_VAL%%#$%] [%#@%%RUN_MOD%%#$%] [%#@%%REG_DAT%%#$%]&&CALL:PAD_LINE
ECHO   PACKAGE CONTENTS:&&SET "BLIST=MAK"&&CALL:FILE_LIST&&CALL:PAD_LINE
IF "%PackType%"=="NULL" ECHO  (%##%X%#$%)Project[%#@%%MAKER_SLOT%%#$%]  (%##%R%#$%)estore  (%##%N%#$%)ew  (%##%D%#$%)river-Export  (%##%I%#$%)nspect-System&&CALL:PAD_LINE
IF "%PackType%"=="DRIVER" ECHO  (%##%X%#$%)Project[%#@%%MAKER_SLOT%%#$%] (%##%C%#$%)reate (%##%R%#$%)estore (%##%N%#$%)ew (%##%E%#$%)dit (%##%Z%#$%)Lvl (%##%P%#$%)ermit (%##%D%#$%)river-Export&&CALL:PAD_LINE
IF "%PackType%"=="SCRIPTED" ECHO  (%##%X%#$%)Project[%#@%%MAKER_SLOT%%#$%]  (%##%C%#$%)reate  (%##%R%#$%)estore  (%##%N%#$%)ew  (%##%E%#$%)dit  (%##%Z%#$%)Lvl  (%##%P%#$%)ermit&&CALL:PAD_LINE
IF "%PackType%"=="AIOPACK" ECHO  (%##%X%#$%)Project[%#@%%MAKER_SLOT%%#$%]  (%##%C%#$%)reate  (%##%R%#$%)estore  (%##%N%#$%)ew  (%##%E%#$%)dit  (%##%Z%#$%)Lvl  (%##%P%#$%)ermit&&CALL:PAD_LINE
IF NOT "%PackType%"=="NULL" IF NOT "%PackType%"=="DRIVER" IF NOT "%PackType%"=="SCRIPTED" IF NOT "%PackType%"=="AIOPACK" ECHO  (%##%X%#$%)Project[%MAKER_SLOT%]  [%##%PackType error%#$%] (%##%R%#$%)estore  (%##%N%#$%)ew  (%##%E%#$%)dit&&CALL:PAD_LINE
ECHO                            Press (%##%Q%#$%) to quit&&CALL:MENU_SELECT
IF NOT DEFINED SELECT GOTO:PACKAGE_CREATOR
IF "%SELECT%"=="Q" EXIT 0
IF "%SELECT%"=="P" CALL:PACK_COND
IF "%SELECT%"=="Z" CALL:PACK_XLVL
IF "%SELECT%"=="N" SET "PACK_MODE=CREATE"&&CALL:PACK_EXAMPLE_MENU&&SET "SELECT="
IF "%SELECT%"=="R" CALL:PACKAGE_RESTORE_CHOICE&&SET "SELECT="
IF "%SELECT%"=="C" IF NOT "%PackType%"=="NULL" SET "PACK_MODE=CREATE"&&CALL:PACKAGE_CREATE&&SET "SELECT="
IF "%SELECT%"=="D" IF NOT "%PackType%"=="SCRIPTED" IF NOT "%PackType%"=="AIOPACK" CALL:DRIVER_EXPORT&&SET "SELECT="
IF "%SELECT%"=="I" IF NOT "%PackType%"=="SCRIPTED" IF NOT "%PackType%"=="AIOPACK" CALL:PACKAGE_INSPECT&&SET "SELECT="
IF "%SELECT%"=="E" SET "EDIT_SETUP=1"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_README=1"&&SET "EDIT_LIST=1"&&SET "EDIT_CUSTOM="&&CALL:PACKAGE_EDITOR
IF "%SELECT%"=="X" SET /A "MAKER_SLOT+=1"&&IF "%MAKER_SLOT%" GEQ "5" SET "MAKER_SLOT=1"
IF "%SELECT%"=="X" SET "MAKER_FOLDER=%PROG_SOURCE%\Project%MAKER_SLOT%"
GOTO:PACKAGE_CREATOR
:DRIVER_EXPORT
SET "PackType=DRIVER"&&IF "%PackName%"=="NULL" SET "PackName=DRIVER_%RANDOM%"
IF NOT EXIST "%MAKER_FOLDER%" MD "%MAKER_FOLDER%">NUL 2>&1
CALL:PAD_LINE&&ECHO                        Exporting System Drivers&&CALL:PAD_LINE&&DISM /ENGLISH /ONLINE /EXPORT-DRIVER /destination:"%MAKER_FOLDER%"&&CALL:PACK_MANIFEST
CALL:PAD_LINE&&ECHO                            Driver Export End&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:PACKAGE_INSPECT
CALL:PAD_LINE&&ECHO                          Driver Inspect Start&&CALL:PAD_LINE&&DISM /ENGLISH /ONLINE /GET-DRIVERS&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:PACKAGE_RESTORE_CHOICE
CLS&&CALL:PAD_LINE&&ECHO %S26%Restore which type&&CALL:PAD_LINE&&ECHO.&&ECHO  (%##%1%#$%)PKG Package [%#@%Driver/Scripted%#$%]&&ECHO  (%##%2%#$%)PKX Package [%#@%AIO Package%#$%]&&ECHO.&&SET "PROMPT_SET=MAKER_RESTORE"&&CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:PROMPT_SET
IF "%MAKER_RESTORE%"=="1" SET "PICK=PKG"
IF "%MAKER_RESTORE%"=="2" SET "PICK=PKX"
CALL:FILE_PICK&&CALL:PACKAGE_RESTORE
EXIT /B
:PACKAGE_RESTORE
IF NOT DEFINED $PICK EXIT /B
CALL:PAD_LINE&&ECHO                   Project[%#@%%MAKER_SLOT%%#$%] folder will be cleared&&CALL:PAD_LINE&&ECHO.                         Press (%##%X%#$%) to proceed
CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=CONFIRM"&&CALL:PROMPT_SET
IF NOT "%CONFIRM%"=="X" EXIT /B
CALL:PAD_LINE&&ECHO.                          Package Restore Start&&CALL:PAD_LINE&&ECHO.                            Restoring Package
CALL:SCRATCH_PACK_CREATE&&DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%$PICK%" /INDEX:2 /APPLYDIR:"%PROG_SOURCE%\ScratchPack">NUL 2>&1
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=NULL")
IF EXIST "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" COPY /Y "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (IF NOT DEFINED %%a CALL SET "%%a=NULL")
IF EXIST "$PAK" DEL /F "$PAK">NUL
IF NOT EXIST "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" CALL:PAD_LINE&&ECHO Package %##%%PackName%%#$% is defunct.&&CALL:PAD_LINE&&SET "PACK_DEFUNCT=1"&&CALL:PAUSED
IF EXIST "%MAKER_FOLDER%" RD /S /Q "%MAKER_FOLDER%">NUL 2>&1
IF NOT EXIST "%MAKER_FOLDER%" MD "%MAKER_FOLDER%">NUL 2>&1
MOVE /Y "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" "%MAKER_FOLDER%">NUL 2>&1
DISM /ENGLISH /APPLY-IMAGE /IMAGEFILE:"%$PICK%" /INDEX:1 /APPLYDIR:"%MAKER_FOLDER%"
ECHO.&&CALL:PAD_LINE&&ECHO.                          Package Restore End&&CALL:PAD_LINE&&CALL:PAUSED
EXIT /B
:PACKAGE_CREATE
SET "PACK_FAIL="&&CALL:PAD_LINE&&ECHO.                         Package Create Start&&CALL:PAD_LINE&&ECHO.                           Creating Package&&CALL:SCRATCH_PACK_DELETE
IF NOT EXIST "%MAKER_FOLDER%\*.*" SET "PACK_FAIL=1"&&CALL:PAD_LINE&&ECHO.%#@%Project%MAKER_SLOT% is empty%#$%&&CALL:PAD_LINE&&CALL:PAUSED
IF NOT DEFINED PackName SET "PACK_FAIL=1"&&CALL:PAD_LINE&&ECHO.PackName is Empty&&CALL:PAD_LINE&&CALL:PAUSED
IF NOT DEFINED PackType SET "PACK_FAIL=1"&&CALL:PAD_LINE&&ECHO.PackType is Empty&&CALL:PAD_LINE&&CALL:PAUSED
IF DEFINED PACK_FAIL EXIT /B
CALL:SCRATCH_PACK_CREATE&&MOVE /Y "%MAKER_FOLDER%\PACKAGE.MAN" "%PROG_SOURCE%\ScratchPack">NUL 2>&1
IF "%PackType%"=="AIOPACK" (SET "GX=x") ELSE (SET "GX=g")
DISM /ENGLISH /CAPTURE-IMAGE /CAPTUREDIR:"%MAKER_FOLDER%" /IMAGEFILE:"%PROG_SOURCE%\%PackName%.pk%GX%" /COMPRESS:%PACK_XLVL% /NAME:"%PackName%" /CheckIntegrity /Verify
DISM /ENGLISH /APPEND-IMAGE /IMAGEFILE:"%PROG_SOURCE%\%PackName%.pk%GX%" /CAPTUREDIR:"%PROG_SOURCE%\ScratchPack" /NAME:"%PackName%" /Description:WINDICK /CheckIntegrity /Verify>NUL 2>&1
MOVE /Y "%PROG_SOURCE%\ScratchPack\PACKAGE.MAN" "%MAKER_FOLDER%">NUL 2>&1
CALL:SCRATCH_PACK_DELETE&&ECHO.&&CALL:PAD_LINE&&ECHO.                           Package Create End&&CALL:PAD_LINE&&IF NOT "%PACK_MODE%"=="INSTANT" CALL:PAUSED
EXIT /B
:PACKAGE_EDITOR
IF DEFINED EDIT_MANIFEST IF EXIST "%MAKER_FOLDER%\PACKAGE.MAN" START NOTEPAD.EXE "%MAKER_FOLDER%\PACKAGE.MAN"
IF DEFINED EDIT_LIST IF EXIST "%MAKER_FOLDER%\PACKAGE.LST" START NOTEPAD.EXE "%MAKER_FOLDER%\PACKAGE.LST"
IF DEFINED EDIT_SETUP IF EXIST "%MAKER_FOLDER%\PACKAGE.CMD" START NOTEPAD.EXE "%MAKER_FOLDER%\PACKAGE.CMD"
IF DEFINED EDIT_README IF EXIST "%MAKER_FOLDER%\README.TXT" START NOTEPAD.EXE "%MAKER_FOLDER%\README.TXT"
IF DEFINED EDIT_CUSTOM IF EXIST "%MAKER_FOLDER%\%EDIT_CUSTOM%" START NOTEPAD.EXE "%MAKER_FOLDER%\%EDIT_CUSTOM%"
SET "EDIT_SETUP="&&SET "EDIT_MANIFEST="&&SET "EDIT_README="&&SET "EDIT_CUSTOM="&&SET "EDIT_LIST="
EXIT /B
:PACK_XLVL
SET /A "PAK_XXX+=1"
IF "%PAK_XXX%" GTR "3" SET "PAK_XXX=1"
IF "%PAK_XXX%"=="1" SET "PACK_XLVL=FAST"
IF "%PAK_XXX%"=="2" SET "PACK_XLVL=MAX"
IF "%PAK_XXX%"=="3" SET "PACK_XLVL=NONE"
EXIT /B
:PACK_COND
CALL ECHO Input REG-KEY&&ECHO (Case sensitive^^!)&&SET "PROMPT_ANY=1"&&CALL:PROMPT_SET
CALL SET "REG_KEY=%SELECT%"
IF NOT DEFINED REG_KEY SET "REG_VAL="&&SET "RUN_MOD="&&SET "REG_DAT="&&CALL:PACK_MANIFEST&&EXIT /B
CALL ECHO Input REG-VALUE&&ECHO (Case sensitive^^!)&&SET "PROMPT_ANY=1"&&CALL:PROMPT_SET
CALL SET "REG_VAL=%SELECT%"
IF NOT DEFINED REG_VAL EXIT /B
CALL REG QUERY "%REG_KEY%" /V "%REG_VAL%" >"$HZ"
SET "COL1="&&IF EXIST $HZ FOR /F "TOKENS=* DELIMS=" %%1 in ($HZ) DO (SET "COL1=%%1")
CALL ECHO [%COL1%]&&DEL "$HZ">NUL 2>&1
CALL ECHO Input REG-VALUE target data&&ECHO (Case sensitive^^!)&&SET "PROMPT_ANY=1"&&CALL:PROMPT_SET
CALL SET "REG_DAT=%SELECT%"
ECHO Permit install if data&&ECHO (%##%1%#$%)Match&&ECHO (%##%2%#$%)Does NOT match&&CALL:MENU_SELECT
IF NOT DEFINED SELECT SET "RUN_MOD=EQU"
IF "%SELECT%"=="1" SET "RUN_MOD=EQU"
IF "%SELECT%"=="2" SET "RUN_MOD=NEQ"
CALL:PACK_MANIFEST
EXIT /B
:PAK_LOAD
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=NULL")
IF EXIST "%MAKER_FOLDER%\PACKAGE.MAN" COPY /Y "%MAKER_FOLDER%\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (IF NOT "%%a"=="   " SET "%%a=%%b")
DEL /Q /F "$PAK">NUL 2>&1
EXIT /B
:PACK_SAVE
MOVE /Y "%MAKER_FOLDER%\PACKAGE.MAN" "$PAK">NUL&&FOR /F "eol=- TOKENS=1-2 DELIMS==" %%a in ($PAK) DO (CALL ECHO %%a=%%%%a%%>>"%MAKER_FOLDER%\PACKAGE.MAN")
DEL /Q /F "$PAK">NUL 2>&1
EXIT /B
:PACK_MANIFEST
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (IF NOT DEFINED %%a CALL SET "%%a=NULL")
(ECHO ----------[Package Manifest]---------=&&ECHO.PackName=%PackName%&&ECHO.PackType=%PackType%&&ECHO.PackDesc=%PackDesc%&&ECHO.PackTag=%PackTag%&&ECHO.REG_KEY=%REG_KEY%&&ECHO.REG_VAL=%REG_VAL%&&ECHO.RUN_MOD=%RUN_MOD%&&ECHO.REG_DAT=%REG_DAT%&&ECHO.Created=%date% %time%&&ECHO ------------[END OF FILE]------------=)>"%MAKER_FOLDER%\PACKAGE.MAN"
EXIT /B
:PACK_STRT
(ECHO.::================================================&&ECHO.::File and registry locations are normal during&&ECHO.::SetupComplete, RunOnce, and Current-Environment.&&ECHO.::During ImageApply they are externally mounted.&&ECHO.::================================================&&ECHO.::These variables are built in and can help&&ECHO.::keep a script consistant throughout the entire&&ECHO.::process, whether applying to a vhdx or live.&&ECHO.::================================================&&ECHO.::Windows folder :    %%WINTAR%%&&ECHO.::Drive root :        %%DRVTAR%%&&ECHO.::User or defuser :   %%USRTAR%%&&ECHO.::HKLM\SOFTWARE :     %%HIVE_SOFTWARE%%&&ECHO.::HKLM\SYSTEM :       %%HIVE_SYSTEM%%&&ECHO.::HKCU\ or defuser :  %%HIVE_USER%%&&ECHO.::================================================&&ECHO.::==================START OF PACK=================&&ECHO.)>"%NEW_PACK%"
EXIT /B
:PACK_END
(ECHO.&&ECHO.::===================END OF PACK==================&&ECHO.::================================================)>>"%NEW_PACK%"
EXIT /B
:PACK_EXAMPLE_MENU
CLS&&CALL:PAD_LINE&&ECHO                         (New Package Template)&&CALL:PAD_LINE
ECHO  (%##%N01%#$%) New Driver Package                                  (%#@%DRIVER%#$%)
ECHO  (%##%N02%#$%) New Scripted Package                                (%#@%SCRIPTED%#$%)
ECHO  (%##%N03%#$%) New AIO Package                                     (%#@%AIOPACK%#$%)
:PACKEX_JUMP
CALL:PAD_LINE&&CALL:PAD_PREV&&CALL:MENU_SELECT
IF NOT DEFINED SELECT EXIT /B
SET "EXAMPLE=%SELECT%"&&SET "PASS="&&FOR %%a in (N01 N02 N03) DO (IF "%%a"=="%SELECT%" SET "PASS=1")
IF NOT "%PASS%"=="1" EXIT /B
IF "%PACK_MODE%"=="CREATE" CALL:PAD_LINE&&ECHO                   Project[%#@%%MAKER_SLOT%%#$%] folder will be cleared&&CALL:PAD_LINE&&ECHO.                         Press (%##%X%#$%) to proceed&&CALL:PAD_LINE&&CALL:PAD_PREV&&SET "PROMPT_SET=CONFIRM"&&CALL:PROMPT_SET
IF "%PACK_MODE%"=="CREATE" IF NOT "%CONFIRM%"=="X" EXIT /B
IF EXIST "%MAKER_FOLDER%" RD /S /Q "\\?\%MAKER_FOLDER%">NUL 2>&1
IF NOT EXIST "%MAKER_FOLDER%" MD "%MAKER_FOLDER%">NUL 2>&1
SET "NEW_PACK=%MAKER_FOLDER%\PACKAGE.CMD"&&CALL:SCRATCH_PACK_DELETE
FOR %%a in (PackName PackType PackDesc PackTag REG_KEY REG_VAL RUN_MOD REG_DAT) DO (CALL SET "%%a=NULL")
CALL:%EXAMPLE%
CALL:PACK_MANIFEST>NUL 2>&1
IF "%PackType%"=="SCRIPTED" CALL:PACK_END
IF "%PACK_MODE%"=="CREATE" IF DEFINED EXAMPLE CALL:PACKAGE_EDITOR
IF "%PackType%"=="AIOPACK" IF EXIST "%NEW_PACK%" DEL /F "%NEW_PACK%">NUL 2>&1
IF "%PackType%"=="DRIVER" IF EXIST "%NEW_PACK%" DEL /F "%NEW_PACK%">NUL 2>&1
SET "PACK_MODE="&&SET "SELECT="&&CALL:SCRATCH_PACK_DELETE
EXIT /B
:N01
SET "PackType=DRIVER"&&CALL:PAD_LINE&&ECHO                     - New Driver Pack (PKG) Name -&&CALL:PAD_LINE&&SET "PROMPT_SET=PackName"&&SET "PROMPT_ANY=1"&&CALL:PROMPT_SET
IF NOT DEFINED PackName SET PackName=Driver_%RANDOM%
EXIT /B
:N02
CALL:PACK_STRT&&SET "PackType=SCRIPTED"&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&CALL:PAD_LINE&&ECHO                    - New Scripted Pack (PKG) Name -&&CALL:PAD_LINE&&SET "PROMPT_SET=PackName"&&SET "PROMPT_ANY=1"&&CALL:PROMPT_SET
IF NOT DEFINED PackName SET PackName=Scripted_%RANDOM%
EXIT /B
:N03
SET "PackType=AIOPACK"&&CALL:PAD_LINE&&SET "EDIT_MANIFEST=1"&&SET "EDIT_SETUP=1"&&ECHO                        - New AIO Pack (PKX) Name -&&CALL:PAD_LINE&&SET "PROMPT_SET=PackName"&&SET "PROMPT_ANY=1"&&CALL:PROMPT_SET
IF NOT DEFINED PackName SET PackName=AIOPACK_%RANDOM%
ECHO EXEC-LIST>"%MAKER_FOLDER%\PACKAGE.LST"
ECHO Manually add/copy/paste items or replace the PACKAGE.LST (this) with an existing list.>>"%MAKER_FOLDER%\PACKAGE.LST"
ECHO Copy all listed packages to ADD (APPX/CAB/MSU/PKG) into project folder before package creation.>>"%MAKER_FOLDER%\PACKAGE.LST"
EXIT /B
:MENU_SELECT
SET "SELECT="&&SET /P "SELECT=$>>"
IF DEFINED SELECT SET "CAPS_SET=SELECT"&&SET "CAPS_VAR=%SELECT%"&&CALL:CAPS_SET
CALL SET "$ELECTMP=%%$ITEM%SELECT%%%"&&IF DEFINED SELECT CALL SET "$ELECT=%SELECT%"
IF DEFINED SELECT IF DEFINED $ELECTMP CALL SET "$ELECT$=%$ELECTMP%"
EXIT /B
:PROMPT_SET
IF NOT DEFINED PROMPT_SET SET "PROMPT_SET=SELECT"
SET "PROMPT_VAR="&&SET /P "PROMPT_VAR=$>>"
SET "CAPS_SET=%PROMPT_SET%"&&SET "CAPS_VAR=%PROMPT_VAR%"
IF DEFINED PROMPT_ANY CALL SET "%CAPS_SET%=%CAPS_VAR%"
IF NOT DEFINED PROMPT_ANY CALL:CAPS_SET
SET "PROMPT_ANY="&&SET "PROMPT_SET="&&SET "PROMPT_VAR="
EXIT /B
:CAPS_SET
FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "CAPS_VAR=%%CAPS_VAR:%%G=%%G%%")
CALL SET "%CAPS_SET%=%CAPS_VAR%"&&SET "CAPS_SET="&&SET "CAPS_VAR="
EXIT /B
:CHAR_CHK
FOR %%a in (CHAR_STR CHAR_CHK) DO (IF NOT DEFINED %%a EXIT /B)
SET "CHAR_FLG="&&FOR /F "DELIMS=" %%$ in ('CMD.EXE /D /U /C ECHO %CHAR_STR%^| FIND /V ""') do (IF "%%$"=="%CHAR_CHK%" SET "ERROR=1"&&SET "CHAR_FLG=1")
EXIT /B
:CHECK
SET "ERROR="&&IF NOT DEFINED SELECT SET "ERROR=1"
SET "CHAR_CHK= "&&SET "CHAR_STR=%SELECT%"&&CALL:CHAR_CHK
IF "%CHECK%"=="NUM" IF "%SELECT%" LSS "0" SET "ERROR=1"
IF "%CHECK%"=="NUM" IF "%SELECT%" GTR "9999999" SET "ERROR=1"
IF "%CHECK%"=="NUM" SET "CAPS_SET=SELECT"&&SET "CAPS_VAR=%SELECT%"&&CALL:CAPS_SET
IF "%CHECK%"=="NUM" FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (SET "CHAR_CHK=%%G"&&SET "CHAR_STR=%SELECT%"&&CALL:CHAR_CHK)
SET "CHECK="
EXIT /B
:PAD_LINE
ECHO [92m=====================================================================[97m
EXIT /B
:PAD_PREV
ECHO                Press (%##%Enter%#$%) to return to previous menu
EXIT /B
:PAUSED
SET /P "PAUSED=.                      Press (%##%Enter%#$%) to continue..."
EXIT /B
:FILE_PICK
IF NOT DEFINED PICK GOTO:PICK_ERROR
CLS&&CALL:PAD_LINE&&ECHO                              File Picker&&CALL:PAD_LINE&&ECHO   AVAILABLE %PICK%'S:
SET "NLIST=%PICK%"&&CALL:FILE_LIST&&CALL:PAD_LINE&&ECHO                              Select a (%##%#%#$%)&&CALL:PAD_LINE&&CALL:PAD_PREV
FOR %%a in (ERROR SELECT $PICK $ELECT $ELECT$) DO (SET "%%a=")
SET /P "SELECT=$>>"&&FOR %%G in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO (CALL SET "SELECT=%%SELECT:%%G=%%G%%")
IF "%SELECT%" GTR "9999999" SET "ERROR=1"
IF "%SELECT%" LSS "0" SET "ERROR=1"
IF DEFINED ERROR GOTO:PICK_ERROR
CALL SET "$ELECT=%SELECT%"&&CALL SET "$ELECT$=%%$ITEM%SELECT%%%"
IF NOT DEFINED $ELECT$ SET "ERROR=1"&&GOTO:PICK_ERROR
FOR %%a in (PKG PKX) DO (IF "%PICK%"=="%%a" SET "$FOLD=%PROG_SOURCE%")
IF NOT EXIST "%$FOLD%\%$ELECT$%" SET "ERROR=1"&&GOTO:PICK_ERROR
IF EXIST "%$FOLD%\%$ELECT$%" SET "$PICK=%$FOLD%\%$ELECT$%"
:PICK_ERROR
SET "PICK="&&IF DEFINED ERROR SET "$PICK="
EXIT /B
:FILE_LIST
SET "$FOLD="&&FOR %%a in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30) DO (IF DEFINED $ITEM%%a SET "$ITEM%%a=")
IF NOT DEFINED BLIST IF NOT DEFINED NLIST GOTO:FILE_ERROR
IF DEFINED BLIST SET "$MENU=BAS"&&SET "EXT=%BLIST%"
IF DEFINED NLIST SET "$MENU=NUM"&&SET "EXT=%NLIST%"
FOR %%a in (PKG PKX) DO (IF "%EXT%"=="%%a" SET "$FOLD=%PROG_SOURCE%\*.%EXT%"&&SET "$LABEL=PACK")
ECHO.&&IF "%EXT%"=="MAK" SET "$FOLD=%MAKER_FOLDER%\*.*"&&SET "$LABEL=Project%MAKER_SLOT%"
IF NOT EXIST "%$FOLD%" ECHO  [%#@%EMPTY..%#$%]
IF EXIST "%$FOLD%" SET "$XNT="&&DIR "%$FOLD%" /A: /B /O:GN>$HZ&&FOR /F "TOKENS=*" %%a in ($HZ) DO (IF NOT "%%a"=="$HZ" CALL SET /A "$XNT+=1"&&CALL SET "$CLM$=%%a"&&CALL:FILE_LISTX)
ECHO.&&IF EXIST "$HZ" DEL /F "$HZ">NUL 2>&1
:FILE_ERROR
FOR %%a in (EXT BLIST NLIST CRICKETS NOECHO1 NOECHO2 MENU_INSERTA $MENU $FOLD $LABEL) DO (SET "%%a=")
EXIT /B
:FILE_LISTX
CALL SET "$ITEM%$XNT%=%$CLM$%"
IF "%$MENU%"=="NUM" ECHO  [ %##%%$XNT%%#$% ]\[%#@%%$CLM$%%#$%]
IF "%$MENU%"=="BAS" ECHO  [%#@%%$LABEL%%#$%]\[%#@%%$CLM$%%#$%]
EXIT /B
:SCRATCH_PACK_DELETE
SET "SCRATCH_PACK=%PROG_SOURCE%\ScratchPack"&&IF EXIST "%PROG_SOURCE%\ScratchPack" DISM /cleanup-MountPoints>NUL 2>&1
IF EXIST "%PROG_SOURCE%\ScratchPack" ATTRIB -R -S -H "%PROG_SOURCE%\ScratchPack" /S /D /L>NUL 2>&1
IF EXIST "%PROG_SOURCE%\ScratchPack" RD /S /Q "\\?\%PROG_SOURCE%\ScratchPack">NUL 2>&1
EXIT /B
:SCRATCH_PACK_CREATE
SET "SCRATCH_PACK=%PROG_SOURCE%\ScratchPack"&&IF EXIST "%PROG_SOURCE%\ScratchPack" CALL:SCRATCH_PACK_DELETE 
IF NOT EXIST "%PROG_SOURCE%\ScratchPack" MD "%PROG_SOURCE%\ScratchPack">NUL 2>&1
EXIT /B