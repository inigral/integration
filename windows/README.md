# TargetX Windows Integration

This repository contains information to automate integration of student CSV data with TargetX via SFTP.  If you do not have your SFTP credentials, please contact TargetX.  This package contains a BATCH script sendcsv.bat that should work on all modern versions of Windows.

## Usage

You only need to set a few variables in the script for it to function. Then
you can run the script manually or schedule it to be run via the Control
Panel's Scheduled Tasks panel.

First open sendcsv.bat with your text editor

Find the line to set your username:
 ```
 SET USERNAME="YOUR USERNAME"
 ```
Change this to the username TargetX provided you.
e.g.
```
SET USERNAME="abu"
```

Next find the line to set your password:
```
SET PASSWORD="YOUR PASSWORD"
```
And set it to the password provided to you e.g.
```
SET PASSWORD="aBcdE7jfG"
```

You should now be able to run the script and point it to the file you want to upload.  
For instance if you wanted to send `myfile.csv`
```
send_csv.bat myfile.csv
```

Note: The file path is relative to the script's location, so if you had a
file called `myfile.csv` in the same directory, then it would work as is.
If the file is located somewhere else on your computer such as the desktop, make sure to use its full path:
```
send_csv.bat C:\Users\yourusername\Desktop\file.csv
```

The script should upload the file to
TargetX. If you have any problems, there are helpful tips you can read at
the end of the send_csv file or you may contact TargetX directly.

Note: You can also enable logging by setting the EXTRA_WINSCP_ARGS, as
specified in the script.

You can also integrate the `sendcsv.bat` into your existing processes. For an
example of using `sendcsv.bat`, see `sample_driver.bat`. `sample_driver.bat` will
upload an entire directory full of CSVs. To change the directory, open
sample_driver.bat, and edit the DIRECTORY parameter.
