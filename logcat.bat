adb wait-for-device
@echo off
adb logcat -g
adb logcat -c
@echo on
adb logcat -v threadtime > %1_main.log