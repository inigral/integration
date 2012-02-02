===================== INIGRAL WINDOWS INTEGRATION README ======================

This archive contains the sendcsv.bat script, which can be used in an automated
way to integrate your student CSV data with Inigral via sFTP. This package
contains a BATCH script, sendcsv.bat, which should work on all modern versions
of MS Windows.

Version     - 1.0
Date        - 2/1/2012

============================== Using sendcsv.bat ==============================

You only need to set a few variables in the script for it to function. Then,
you can run the script manually or schedule it to be run via the Control
Panel's Scheduled Tasks panel.

 * Open sendcsv.bat with your favorite text editor
 
 * Send your USERNAME, and PASSWORD
 
   * While passwords are great for testing, we suggest you use an SSH Key when
     you decide to go to production. SSH keys are more secure and easy to use.
	 Just follow the directions in this document, "Generating an SSH Key", and
	 set the SSH_KEY_FILE variable instead.
 
 * By default, FILE will read from the first command-line paramater passed.
   Alternatively, you can set FILE to the location of the CSV file you wish to 
   upload. The file path is relative to the script's location, so if you had a 
   file called your.csv in this directory, then it would work as configured. 
   You can also use a full system file path (i.e. C:\file.csv).
 
 * That's it! You can now run the script and it should upload the file to
   Inigral. If you have any problems and wish to debug, feel free to read to
   the end of the script. Lots of comments have been provided to assist. Note
   that you can also enable logging by setting the EXTRA_WINSCP_ARGS, as
   specified in the script.

   Example: sendcsv.bat myfile.csv

You can also integrate the sendcsv.bat into your existing processes. For an
example of using sendcsv.bat, see sample_driver.bat. sample_driver.bat will
upload an entire directory full of CSVs. To change the directory, open
sample_driver.bat, and edit the DIRECTORY parameter.
   
============================ Generating an SSH Key ============================

Using an SSH Key is more secure than a password alone. It is simple to generate
and use following these directions.

 * Download the PuttyGen program from: http://winscp.net/download/puttygen.exe
 
 * Run the program.
 
 * Click "Generate"
 
 * Move your mouse randomly in the blank area to speed up key generation
 
 * Copy the "Public key for pasting into OpenSSH authorized_key file" and send
   to your Clientologist at Inigral.
 
 * Ensure passphrase is empty (or you will be required to type a password every
   time you wish to upload a CSV.
 
 * Click "Save private key"
 
 * Say "Yes" to the question "Are you sure you want to save this key without a
   passphrase to protect it?"
 
 * Store the key in the folder with sendcsv.bat. Be careful with this file,
   it will be used in place of your password and should be treated as
   sensitive data.
 
 * Open sendcsv.bat, set PASSWORD="" and set SSH_KEY_FILE to the file you just
   created (i.e. mykey.ppk)

= Revision History =

= 2/1/2012 - Version 1.0 =
  * Initial release of tool
  * Package contains WinSCP standalone &
  * sendcsv.bat, a script to send your CSV to Inigral