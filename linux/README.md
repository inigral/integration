# TargetX Mac & Linux Integration

This repository contains information to automate integration of student CSV data with TargetX via SFTP.  If you do not have your SFTP credentials, please contact TargetX.

## Usage

In order to automate integrations you will need your SFTP credentials and your custom `send_csv.sh` script.
Once you have your credentials and custom script, you can run the script manually or schedule it to be run via the Control
Panel's Scheduled Tasks panel or another automation tool (e.g. OS X Automator).

Example, from terminal:
```
./send_csv.sh myfile.csv
```

Note: The file path is relative to the script's location, so if you had a
file called myfile.csv in the same directory, then it would work as is.
If the file is located somewhere else on your computer, make sure to use its full path:
 ```
 ./send_csv.sh /path/to/myfile.csv
```

The script should upload the file to
TargetX. If you have any problems, there are helpful tips you can read at
the end of the send_csv file or you may contact TargetX directly.

You can also integrate the send_csv.sh into your existing processes. For an
example of using send_csv.sh, see sample_driver.sh. sample_driver.sh will
upload an entire directory full of CSVs. To change the directory, open
sample_driver.sh, and edit the DIRECTORY parameter.
