@echo off
rem 2021-02-10 Sukri Created.

rem script name.
set "script_name=Load-puttyPageant-privateKeys.ps1"

rem script directory.
set "script_directory=%~dp0"

rem execute PS1 script.
PowerShell -ExecutionPolicy bypass -file "%script_directory%%script_name%"

rem pause, press any key to exit.
rem pause