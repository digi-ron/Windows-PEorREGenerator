:: set below variables as required
set ADKLocation=C:\Windows Kits\10\Assessment and Deployment Kit
set ImageArchitecture=amd64

::script defined variables
set MountFolder=%~dp0mount
set WinPEFolder=%~dp0wpe
set WinRESourceFilesFolder=%~dp0sourcefiles
set AdditionalFilesFolderSys32=%~dp0System32_UserDefined

::logic
call "%ADKLocation%\Deployment Tools\DandISetEnv.bat"
:: create the blank image according to the specifications set above
call copype %ImageArchitecture% %WinPEFolder%
copy /b/v/y %WinRESourceFilesFolder%\winre.wim %WinPEFolder%\media\sources\boot.wim
del "%WinPEFolder%\media\Boot\bootfix.bin"
pause
:: allow copype and makewinpemedia commands through the use of the staging script for the installed terminal
call "%ADKLocation%\Deployment Tools\DandISetEnv.bat"
Dism /Mount-Image /ImageFile:"%WinPEFolder%\media\sources\boot.wim" /Index:1 /MountDir:"%MountFolder%"
Dism /Add-Package /Image:"%MountFolder%" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\WinPE-GamingPeripherals.cab"
echo copying from relative system32 folder
xcopy /E /H /Y "%AdditionalFilesFolderSys32%\*.*" "%MountFolder%\Windows\System32\*.*"
echo preparing to unmount image and save file
pause
Dism /Unmount-Image /MountDir:"%MountFolder%" /Commit
pause
call makewinpemedia /ISO "%WinPEFolder%" "%~dp0output.iso"
echo cleaning useless files
rmdir /s /q %WinPEFolder%
pause
exit