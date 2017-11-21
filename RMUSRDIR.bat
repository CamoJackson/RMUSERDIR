REM Jackson's Quick Delete
@echo off
:error
rem Verifi user Intentions
echo "Are you sure you want to run this tool and delete all of the user files?"
set /p id="Y or N: "
if /I "%id%"=="Y" (
	rem copy Directory structure
	dir /AD /B >usr.txt
	rem Remove Current Users
	type usr.txt | findstr /v %USERNAME% > usr2.tx
	del usr.txt
	rem iterate over all of the users that are left
	For /f %%j in (usr2.txt) Do (
		echo %%j
		cd %%j
		rem del all files and folders
		del /q /f *
		rd /s /q %CD%\%%j
		cd ..
	)
	del usr2.txt
	rem switch to currnet user
	cd %USERNAME%
	rem del files
	del /q /f *
	rem get directorys
	dir /AD /B > dir.txt
	rem remove Desktop and AppData from delete list
	type dir.txt | findstr /v Desktop > dir2.txt
	type dir2.txt | findstr /v AppData > dir.txt
	del dir2.txt
	for /f %%a in (dir.txt) Do (
		rem del folders
		rd /s /q %%a
	)
	del dir.txt
	cd ..
	cls
	rem sucsses
	echo del sucsses
	goto end
)
rem if usr said no
if /I "%id%"=="N" goto end
rem if usr inputs bad character
cls
echo error
goto error
:end
rem close out
echo Goodbye
pause