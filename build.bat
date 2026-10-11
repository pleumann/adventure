@echo off
setlocal
set "OUT=bin\pasta binaries"
if not exist "%OUT%" mkdir "%OUT%"
del /q "%OUT%\*" 2>nul
echo.
echo ================================================
echo === Building for Agon ==========================
echo ================================================
echo.
call pasta80 --agon adventure
tar -a -c -f "%OUT%\agon.zip" adventure.bin ADV.DAT
echo.
echo ================================================
echo === Building for CP/M ==========================
echo ================================================
echo.
call pasta80 --cpm adventure
call pasta80 --cpm advconf
tar -a -c -f "%OUT%\cpm.zip" adventur.com ADV.DAT advconf.com ADVCONF.DAT
echo.
echo ================================================
echo === Building for Next ==========================
echo ================================================
echo.
call pasta80 --zxnext --run --ovr --start 24576 --loader loader.bas adventure
copy /y adv.dat adventure.run >nul
tar -a -c -f "%OUT%\next.zip" adventure.run
endlocal
