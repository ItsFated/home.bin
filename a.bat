@echo off
set allparam=

:param
set str=%1
if "%str%"=="" (
    goto end
)
set allparam=%allparam% %str%
shift /0
goto param

:end
if "%allparam%"=="" (
    goto eof
)

rem remove left right blank
:intercept_left
if "%allparam:~0,1%"==" " set "allparam=%allparam:~1%"&goto intercept_left

:intercept_right
if "%allparam:~-1%"==" " set "allparam=%allparam:~0,-1%"&goto intercept_right

:eof

if not "%allparam:devices=%"=="%allparam%" (adb devices)
if not "%allparam:rr=%"=="%allparam%" (
adb root
echo root over
adb remount
)
if not "%allparam:root=%"=="%allparam%" (
adb root
echo root over
)
if not "%allparam:monkey=%"=="%allparam%" (
:monkey_loop
adb shell svc power stayon true
adb shell monkey -p %allparam:monkey=% 10
timeout 10
goto monkey_loop
)
if not "%allparam:remount=%"=="%allparam%" (adb remount)
if not "%allparam:reboot=%"=="%allparam%" (adb reboot)
if not "%allparam:ptpa=%"=="%allparam%" (adb push %allparam:ptpa=% /system/priv-app/)
if not "%allparam:pta=%"=="%allparam%" (adb push %allparam:pta=% /system/app/)
if not "%allparam:screen=%"=="%allparam%" (adb shell screencap -p /sdcard/Download/screen.png && adb pull /sdcard/Download/screen.png %allparam:screen=%)
if not "%allparam:vrecord=%"=="%allparam%" (adb shell screenrecord --time-limit 10 /sdcard/Download/a.mp4 && adb pull /sdcard/Download/a.mp4 %allparam:vrecord=%)
