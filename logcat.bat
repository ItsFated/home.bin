@echo off
adb logcat -g
adb logcat -c
@echo on
adb logcat -v threadtime > main_%1.log