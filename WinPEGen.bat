:: set below variables as required, examples provided
set ADKLocation=C:\Windows Kits\10\Assessment and Deployment Kit
set ImageArchitecture=amd64
set ProjectLocation=D:\Projects\WinPE

:: everything below this line should auto-execute (assuming the variables are correct)
echo Working from following location: "%~dp0"
pause
:: allow copype and makewinpemedia commands through the use of the staging script for the installed terminal
call "%ADKLocation%\Deployment Tools\DandISetEnv.bat"
:: create the blank image according to the specifications set above
call copype %ImageArchitecture% %ProjectLocation%
echo Ensure above script ran correctly and continue
pause
Dism /Mount-Image /ImageFile:"%ProjectLocation%\media\sources\boot.wim" /Index:1 /MountDir:"%ProjectLocation%\mount"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\WinPE-Dot3Svc.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\WinPE-GamingPeripherals.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\WinPE-NetFX.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\WinPE-PowerShell.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\WinPE-PPPoE.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\WinPE-RNDIS.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\WinPE-Scripting.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\en-us\WinPE-NetFx_en-us.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\en-us\WinPE-PPPoE_en-us.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\en-us\WinPE-RNDIS_en-us.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
Dism /Add-Package /Image:"%ProjectLocation%\mount" /PackagePath:"%ADKLocation%\Windows Preinstallation Environment\%ImageArchitecture%\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
echo Confirm copy from %~dp0System32
pause
xcopy /E /H /Y "%~dp0System32\*.*" "%ProjectLocation%\mount\Windows\System32\*.*"
echo preparing to unmount image and save file
pause
Dism /Unmount-Image /MountDir:"%ProjectLocation%\mount" /Commit
pause
call makewinpemedia /ISO "%ProjectLocation%" "%ProjectLocation%\output.iso"
pause
exit