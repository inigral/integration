@echo off
::
:: sample_driver.bat - Invokes sendcsv.bat on an entire directory of CSV files
:: Version     - 1.0
:: Date        - 2/1/2012
::

:: The directory of CSVs you wish to upload
SET DIRECTORY="C:\CSVs"

:: DeQuote the DIRECTORY variable (remove the "s around it)
CALL:deQuote DIRECTORY

echo Directory: %DIRECTORY%.

:: Loop through every CSV file in the directory and call sendcsv.bat
FOR %%f IN (%DIRECTORY%\*.csv) DO CALL:sendcsv %%f

:: Done!
:end
Echo Done!
GOTO:EOF

::
:: Functions:
::
:sendcsv
echo Uploading: %~1
call sendcsv.bat %~1
GOTO:EOF

:deQuote
FOR /f "delims=" %%A IN ('echo %%%1%%') DO SET %1=%%~A
GOTO:EOF