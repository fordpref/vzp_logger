@echo off
set loop=1
mkdir c:\assessment 2>NUL
mkdir c:\assessment\tmp 2>NUL
set stuff=START
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
    set ftime=%ltime::=.%
    ) ELSE (
    set ltime=%TIME%
    set ftime=%ltime::=.%
    )
    exit /b
:SUB_TEST
    set /p test=Test type:
    exit /b 
:SUB_TESTER
    set /p tester=Tester Name: 
    echo %tester%>c:\assessment\tmp\tester
    exit /b 
:SUB_ASSET
    set /p asset=Customer: 
    cls
    exit /b
:SUB_PROMPT
        set /p tester=<c:\assessment\tmp\tester
        title %stuff%:%tester%:%asset%
	set /p stuff=%CD% #: 
        CALL :SUB_DATE
        CALL :SUB_TIME
        set /p tester=<c:\assessment\tmp\tester
        IF "%stuff:~0,5%"=="user " (
        echo %stuff:~5%>c:\assessment\tmp\tester
        set /p tester=<c:\assessment\tmp\tester
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-log.txt
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-output.txt
        goto SUB_PROMPT
        ) ELSE IF "%stuff:~,4%"=="log " (
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-log.txt
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-output.txt
        goto SUB_PROMPT
        ) ELSE IF "%stuff:~,4%"=="exit" (
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-log.txt
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-output.txt
        del /f c:\assessment\tmp\*
        exit
        ) ELSE (
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-log.txt
        echo %ldate%-%ltime%-%tester%: %stuff% >> c:\assessment\%ldate%-%asset%-%test%-output.txt
        %stuff% > c:\assessment\tmp\temp-%ftime%.txt
        type c:\assessment\tmp\temp-%ftime%.txt >> c:\assessment\%ldate%-%asset%-%test%-output.txt 2>NUL
        type c:\assessment\tmp\temp-%ftime%.txt 2>NUL
        echo >> c:\assessment\%ldate%-%asset%-%test%-output.txt
        del c:\assessment\tmp\temp-%ftime%.txt
        )
        goto SUB_PROMPT
CALL :SUB_PROMPT
