
:loop
adb wait-for-device
@echo off
adb logcat -g
@echo on
adb logcat -v threadtime > "%1_main_%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%.log"
goto loop