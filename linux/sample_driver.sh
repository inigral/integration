#
# sample_driver.sh - Invokes sendcsv.sh on an entire directory of CSV files
# Version     - 1.0
# Date        - 2/2/2012
#

# The directory of CSVs you wish to upload
DIRECTORY="/tmp/csvs"

echo "Directory: $DIRECTORY."

# Loop through every CSV file in the directory and call sendcsv.bat
DIRECTORY="$DIRECTORY/*.csv"
for f in $DIRECTORY; do
	echo "Uploading: $f."
	./sendcsv.sh "$f"
done

echo "Done!"