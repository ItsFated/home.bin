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

if not "%allparam:ds=%"=="%allparam%" (adb devices)
if not "%allparam:root=%"=="%allparam%" (adb root)
if not "%allparam:rm=%"=="%allparam%" (adb remount)
if not "%allparam:rb=%"=="%allparam%" (adb reboot)
