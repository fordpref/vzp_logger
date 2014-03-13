@echo off
set loop=1
CALL :SUB_DATE
CALL :SUB_TIME
CALL :SUB_TEST
CALL :SUB_TESTER
CALL :SUB_ASSET
CALL :SUB_PROMPT
:SUB_DATE
    set builddate=%DATE:~4,10%
    set ldate=%builddate:~6,4%.%builddate:~0,2%.%builddate:~3,2%
    exit /b
:SUB_TIME
    IF "%TIME:~0,1%"==" " (
    set ltime=0%TIME:~1,1%%TIME:~2,9%
    ) ELSE (
    set ltime=%TIME%
    )
    exit /b
:SUB_TEST
    set /p test=OIVE, Pentest, or Other:
    exit /b 
:SUB_TESTER
    set /p tester=Tester Name:
    exit /b 
:SUB_ASSET
    set /p asset=Asset Name: 
    cls
    exit /b
:SUB_PROMPT
	set /p stuff=%CD% #: 
        CALL :SUB_DATE
        CALL :SUB_TIME
        IF "%stuff:~0,5%"=="user " (
        set tester=%stuff:~5%
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-log.txt
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-output.log
        goto SUB_PROMPT
        ) ELSE IF "%stuff:~,4%"=="log " (
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-log.txt
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-output.log
        goto SUB_PROMPT
        ) ELSE (
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-log.txt
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-output.log
        %stuff% > c:\assessment\temp.txt
        type c:\assessment\temp.txt >> c:\assessment\%ldate%-%asset%-%test%-output.log 2>NUL
        type c:\assessment\temp.txt 2>NUL
        echo >> c:\assessment\%ldate%-%asset%-%test%-output.log
        )
        goto SUB_PROMPT
CALL :SUB_PROMPT
