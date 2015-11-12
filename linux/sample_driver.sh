#
# sample_driver.sh - Invokes send_csv.sh on an entire directory of CSV files
# Version     - 1.0
# Date        - 2/2/2012
#

# The directory of CSVs you wish to upload
DIRECTORY="/tmp/csvs"

echo "Directory: $DIRECTORY."

# Loop through every CSV file in the directory and call send_csv.sh
DIRECTORY="$DIRECTORY/*.csv"
for f in $DIRECTORY; do
	echo "Uploading: $f."
	./send_csv.sh "$f"
done

echo "Done!"
