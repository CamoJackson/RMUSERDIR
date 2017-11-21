@echo off
:error
echo "Are you sure you want to run this tool and delete all of the user files?"
set /p id="Y or N: "
if /I "%id%"=="Y" (
	dir /AD /B >usr.txt
	type usr.txt | findstr /v %USERNAME% > usr2.txt
	del usr.txt
	For /f %%j in (usr2.txt) Do (
		echo %%j
		cd %%j
		del /q /f *
		rd /s /q %CD%\%%j
		cd ..
	)
	del usr2.txt
	cd %USERNAME%
	del /q /f *
	dir /AD /B > dir.txt
	type dir.txt | findstr /v Desktop > dir2.txt
	type dir2.txt | findstr /v AppData > dir.txt
	del dir2.txt
	for /f %%a in (dir.txt) Do (
		rd /s /q %%a
	)
	del dir.txt
	cd ..
	cls
	echo del sucsses
	goto end
)
if /I "%id%"=="N" goto end
cls
echo error
goto error
:end
echo Goodbye
pause