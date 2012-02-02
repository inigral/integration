@echo off
::
:: sendcsv.bat - Sends a CSV file to Inigral for integration with your student
::               information database.
:: Version     - 1.0
:: Date        - 2/1/2012
::

::
:: SET THESE VARIABLES
::

:: Your username
SET USERNAME="YOUR USERNAME"

:: Your authentication mechanism (only use one). We suggest you use a 
:: SSH_KEY_FILE as it is more secure. Set SSH_KEY_FILE to a file containing 
:: your SSH private key or "" to disable. With PASSWORD, you should also set 
:: to "" if it is not in use, or your password if it is.
SET SSH_KEY_FILE=""
SET PASSWORD="YOUR PASSWORD"

:: File is the CSV you want to upload. Defaults is that it's provided on the
:: command-line when calling the script (i.e. sendcsv.bat MyFile.csv)
SET FILE="%1"

:: --------------------------------------------------------------------------::
::      Start script, editing beyond this line should not be necessary
:: --------------------------------------------------------------------------::

::
:: SCP_COMMANDS - These commands will be run by the winscp executable. For 
:: documentation regarding these commands, see the Scripting & Task Automation
:: page at http://winscp.net/eng/docs/scripting
:: 
:: Also note: we will be envoking the commands via the WinSCP command-line
:: interface. Docs available at: http://winscp.net/eng/docs/commandline
::
:: We start this empty and add to it calling the addCommand function.
::
SET SCP_COMMANDS=""

:: Any additional arguments to the WinSCP binary can be shoved into this var.
:: Ensure it is always defined, even if it is empty.
SET EXTRA_WINSCP_ARGS=""
REM SET EXTRA_WINSCP_ARGS="/log=log.txt"

:: Set some default values for the connection
SET HOST="sftp.inigral.com"
SET HOST_KEY="ssh-rsa 2048 4b:a1:d8:4f:61:04:90:45:ce:86:30:76:e4:a5:c2:e2"

::
:: DeQuote all the strings (batch is annoying sometimes)
::
CALL:deQuote USERNAME
CALL:deQuote PASSWORD
CALL:deQuote SSH_KEY_FILE
CALL:deQuote FILE
CALL:deQuote SCP_COMMANDS
CALL:deQuote EXTRA_WINSCP_ARGS
CALL:deQuote HOST
CALL:deQuote HOST_KEY

IF EXIST %FILE% GOTO :setup_transfer
echo ERROR: File does not exist: %FILE%. Usage: sendcsv.bat your_file.csv
GOTO :end

:setup_transfer
:: This aborts on any errors with WinSCP
CALL:addCommand "option batch abort"

:: Disable any confirmations (will force overwrite)
CALL:addCommand "option confirm off" 

::
:: Check for authentication mechanism
::
IF "%SSH_KEY_FILE%" NEQ "" goto :key_file
IF "%PASSWORD%" NEQ "" goto :password
echo ERROR: You must specify a password or SSH Key file
GOTO :end

:: SSH key file commands
:key_file
IF NOT EXIST %SSH_KEY_FILE% GOTO :no_key_file
CALL:addCommand "open sftp://""%USERNAME%""@%HOST% -hostkey=""%HOST_KEY%"""
CALL:addWinScpArgs "/privatekey="%SSH_KEY_FILE%""
GOTO :complete_transfer

:no_key_file
echo Your private SSH key file is missing: %SSH_KEY_FILE%.
GOTO :end

:: 
:password
CALL:addCommand "open sftp://""%USERNAME%"":""%PASSWORD%""@%HOST% -hostkey=""%HOST_KEY%"""
GOTO :complete_transfer

::
:: Do transfer
::
:complete_transfer
:: Force binary transfer
CALL:addCommand "option transfer binary"

:: Put the file specified in %FILE%
CALL:addCommand "put %FILE%"

:: Close the connection & exit from WinSCP
CALL:addCommand "close"
CALL:addCommand "exit"

echo Starting transfer...
winscp.exe /console %EXTRA_WINSCP_ARGS% /command %SCP_COMMANDS%
echo Done!
GOTO :end

::
:: Final script endpoint
::
:end
echo Exiting.
GOTO:EOF

::
:: Some supporting functions
::
:addCommand
SET SCP_COMMANDS=%SCP_COMMANDS% "%~1"
GOTO:EOF

:addWinScpArgs
SET EXTRA_WINSCP_ARGS=%EXTRA_WINSCP_ARGS% %~1
GOTO:EOF

:deQuote
FOR /f "delims=" %%A IN ('echo %%%1%%') DO SET %1=%%~A
GOTO:EOF