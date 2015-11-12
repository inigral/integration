#
# sendcsv.bat - Sends a CSV file to Inigral for integration with your student
#               information database.
# Version     - 1.0
# Date        - 2/2/2012
#

# File is the CSV you want to upload. Default is that it's provided on the
# command-line when calling the script (i.e. sendcsv.sh MyFile.csv)
FILE="$1"

# -------------------------------------------------------------------------- #
#      Start script, editing beyond this line should not be necessary
# -------------------------------------------------------------------------- #

HOST="sftp.inigral.com"

if [ ! -f "$FILE" ]
then
  echo "ERROR: File does not exist: $FILE. Usage: sendcsv.sh <your_file.csv>"
  exit 1
fi

SCP=`which scp`
if [ ! "$SCP" ]; then
	echo "SCP executable not found (ensure it is in your PATH)."
	exit 1
fi

if [ ! "$USERNAME" ]; then
	echo "You must set a USERNAME in this script."
	exit 1
fi

#
# Check for authentication mechanism
#
if [ "$PASSWORD" ]; then
	# Use password for authentication

	# The 'expect' binary is required. This will allow us to send commands
	# directly to the scp executable, so we can type the password automatically.
	EXPECT=`which expect`
	if [ ! "$EXPECT" ]; then
		echo "expect executable not found (ensure it is installed and in your PATH)."
		exit 1
	fi

	$EXPECT -c "
            # exp_internal 1 # uncomment for debugging
            spawn $SCP "$FILE" $USERNAME@$HOST:uploaded/
            expect {
              "*password:*" { send $PASSWORD\r\n; interact }
              eof { exit }
            }
            exit
            "
else
	# Do password-less login with your SSH key
	$SCP "$FILE" $USERNAME@$HOST:uploaded/
fi

echo "Done!"
