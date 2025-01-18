@echo off
setlocal
for /f "delims=" %%i in ('powershell -command "Add-Type -AssemblyName System.Windows.Forms; $fileDialog = New-Object System.Windows.Forms.OpenFileDialog; $fileDialog.InitialDirectory = 'C:\'; $fileDialog.ShowDialog(); $fileDialog.FileName"') do set "file=%%i"
curl -F "file=@%file%" https://0x0.st
pause