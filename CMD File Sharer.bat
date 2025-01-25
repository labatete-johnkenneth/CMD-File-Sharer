@echo off
setlocal
:mainloop
set /p var="Enter a number: (Press [1] for file sharing/hosting. [2] for url sharing/hosting. [3] for url lengthening. [4] to delete a file.)"
if %var%==1  (
    goto filesharing
) else if %var%==2 (
    goto urlsharing
) else if %var%==3 (
    goto urllengthening
) else if %var%==4 (
    goto deletefile
) else (
    echo Invalid input, please try again.
    goto mainloop
)

:filesharing
for /f "delims=" %%i in ('powershell -command "Add-Type -AssemblyName System.Windows.Forms; $fileDialog = New-Object System.Windows.Forms.OpenFileDialog; $fileDialog.InitialDirectory = 'C:\'; $fileDialog.ShowDialog(); $fileDialog.FileName"') do set "file=%%i"
set /p var="Do you want a long url: ([1] means yes [2] means no)"
if %var%==1  (
    curl -i -F "file=@%file%" -F secret= https://0x0.st/
    echo Save the X-Token somewhere so you can manually edit your file in the foreseeable future
) else if %var%==2  (
    curl -i -F "file=@%file%" https://0x0.st/
    echo Save the X-Token somewhere so you can manually edit your file in the foreseeable future
) else (
    echo Invalid input, please try again.
    goto filesharing
)
goto end

:urlsharing
set /p url="Enter the url: "
:urlloop
set /p var="Do you want a long url: ([1] means yes [2] means no)"
if %var%==1  (
    curl -i -F "url=%url%" -F secret= https://0x0.st/
    echo Save the X-Token somewhere so you can manually edit your file in the foreseeable future
) else if %var%==2  (
    curl -i -F "url=%url%" https://0x0.st/
    echo Save the X-Token somewhere so you can manually edit your file in the foreseeable future
) else (
    echo Invalid input, please try again.
    goto urlloop
)
goto end

:urllengthening
set /p url="Enter the complete url: (e.g https://0x0.st/8HzA.mp4)"
curl -i -F "url=%url%" -F secret= https://0x0.st/
echo Save the X-Token somewhere so you can manually edit your file in the foreseeable future
goto end

:deletefile
set /p token="Enter the token: "
set /p url="Enter the url: (e.g https://0x0.st/8HzA.mp4)"
curl -F token=%token% -F delete= %url%
goto end

:end
pause
