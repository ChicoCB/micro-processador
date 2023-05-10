@echo off
setlocal enabledelayedexpansion

set GHDL_PATH=D:\UTFPR\5 periodo\arq comp\GHDL\bin\ghdl.exe
set FOLDER_PATH=D:\Repositorios\micro-processador\vhds

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