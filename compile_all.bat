@echo off
setlocal enabledelayedexpansion

set GHDL_PATH=C:\ghdl\GHDL\bin\ghdl.exe
set FOLDER_PATH=C:\Users\franc.ACERASPIRE5\Desktop\micro-processador\vhds

for /r "%FOLDER_PATH%" %%i in (*.vhd) do (
    set FILENAME=%%~ni
    echo Compiling !FILENAME!.vhd
    %GHDL_PATH% -a "%%i"
)

for /r "%FOLDER_PATH%" %%i in (*.vhd) do (
    set FILENAME=%%~ni
    echo Elaborating !FILENAME!
    %GHDL_PATH% -e !FILENAME!
)

echo Done.
pause