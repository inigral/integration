======================= INIGRAL LINUX INTEGRATION README ======================

This archive contains the sendcsv.sh script, which can be used in an automated
way to integrate your student CSV data with Inigral via sFTP. This package
contains a BASH script, sendcsv.sh, which should work on all modern versions
of Linux and some other Unix-based OSes (Mac OS X etc) with the right packages.

Version     - 1.0
Date        - 2/1/2012

=============================== Using sendcsv.sh ==============================

You only need to set a few variables in the script for it to function. Then,
you can run the script manually or schedule it to be run via the Control
Panel's Scheduled Tasks panel.

 * Open sendcsv.sh with your favorite text editor
 
 * Send your USERNAME, and PASSWORD
 
   * While passwords are great for testing, we suggest you use an SSH Key when
     you decide to go to production. SSH keys are more secure and easy to use.
	 Just follow the directions in this document, "Generating an SSH Key."
 
 * By default, FILE will read from the first command-line parameter passed.
   Alternatively, you can set FILE to the location of the CSV file you wish to 
   upload. The file path is relative to the script's location, so if you had a 
   file called your.csv in this directory, then it would work as configured. 
   You can also use a full system file path (i.e. /path/to/file.csv).
 
 * That's it! You can now run the script and it should upload the file to
   Inigral. If you have any problems and wish to debug, feel free to read to
   the end of the script. Lots of comments have been provided to assist.

   Example: sendcsv.sh myfile.csv

You can also integrate the sendcsv.sh into your existing processes. For an
example of using sendcsv.sh, see sample_driver.sh. sample_driver.sh will
upload an entire directory full of CSVs. To change the directory, open
sample_driver.sh, and edit the DIRECTORY parameter.
   
============================ Generating an SSH Key ============================

Using an SSH Key is more secure than a password alone. It is simple to generate
and use following these directions.

 * Login to the system you wish to send files from as the user that will send
   the files. This might mean su/sudo-ing to the correct user.

 * Type: ssh-keygen -t rsa

 * Hit enter to save the file to the default location (~/.ssh/id_rsa).
 
 * Hit enter again to use an empty passphrase. Ensure passphrase is empty (or 
   you will be required to type a password every time you wish to upload a CSV.
 
 * Hit enter when asked to confirm your (empty) passphrase.

 * It should output something like:
     Your public key has been saved in ~/.ssh/id_rsa.pub.

 * Copy the entire contents of this file to an email message to your
   clientologist. You can easily get the contents by: cat ~/.ssh/id_rsa.pub

   * Alternatively, you can just attach the id_rsa.pub file to an email message
 
 * Open sendcsv.sh, and disabled the PASSWORD variable (either by commenting
   it out, or by setting it blank).

NOTE: The ssh-keygen program will generate two files. One called id_rsa, and
      one called id_rsa.pub. The id_rsa.pub file is your "public" key and
      can safely be shared with Inigral, or anyone else you'd like to connect
      to. However, the id_rsa file (without the .pub) will be used in place 
      of your password and should be treated as sensitive data. NEVER give
      out your id_rsa file or its contents to anyone.

= Revision History =

= 2/2/2012 - Version 1.0 =
  * Initial release of tool. Includes:
  * sendcsv.sh, a script to send your CSV to Inigral
  * sample_driver.sh, an example script using sendcsv.sh on a directory