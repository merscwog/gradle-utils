@echo off
setlocal enabledelayedexpansion
set CURR_PATH=%cd%

set REAL_GRADLEW=%CURR_PATH%\gradlew.bat
set REAL_MASTER_GRADLEW=%CURR_PATH%\master\gradlew.bat

rem Check current directory, which might be top directory for gradlew.bat
if exist %REAL_GRADLEW% (
  goto :found
)

rem Check master next to current directory
if exist %REAL_MASTER_GRADLEW% (
  goto :foundInMaster
)

:while1
  call :getdir "%CURR_PATH%"

  set REAL_GRADLEW=!CURR_PATH!\gradlew.bat

  if exist !REAL_GRADLEW! (
    goto :found
  )

  rem Need to check next for a master directory off to the side
  set REAL_MASTER_GRADLEW=!CURR_PATH!\master\gradlew.bat

  if exist !REAL_MASTER_GRADLEW! (
    goto :foundInMaster
  )

  if "%CURR_PATH:~-1%" == ":" (
    goto :notfound
  )
goto :while1

:notfound
echo Unable to find gradlew.bat file upwards in filesystem
goto :goodbye

:found
call !REAL_GRADLEW! %*
goto :goodbye

:foundInMaster
call !REAL_MASTER_GRADLEW! %*
goto :goodbye

:goodbye
endlocal
goto :EOF

:getdir
set "CURR_PATH=%~dp1"
set "CURR_PATH=%CURR_PATH:~0,-1%"
