@echo off

rem The internet connection in my house drops all the time.
rem So I modified this script from sabo-fx ( https://stackoverflow.com/a/32185695 ) 
rem to check every 10 Minutes if Google's DNS 8.8.8.8 is pingable and create a logfile.
rem With these infos I can check if my neighbours have the same problem at the same time 
rem and hopefully convince my ISP that their service sucks and get my money back!
rem Use and modify to your needs.


set host=8.8.8.8
echo WARNING: You maybe have to run this script as administrator.
echo To avoid saving the logs in the System32 folder us a path for filename
echo e.g.: %HOMEDRIVE%%HOMEPATH%\filename
set /p logfile=filename:
set extension=.log
set logfile=%logfile%%extension%

echo Target Host = %host% >%logfile%
for /f "tokens=*" %%A in ('ping %host% -n 1 ') do (echo %%A>>%logfile% && GOTO Ping)
:Ping
for /f "tokens=* skip=2" %%A in ('ping %host% -n 1 ') do (
    echo %date% %time:~0,2%:%time:~3,2%:%time:~6,2% %%A>>%logfile%
    echo %date% %time:~0,2%:%time:~3,2%:%time:~6,2% %%A
    timeout /T 600 /NOBREAK >NUL 
    GOTO Ping)