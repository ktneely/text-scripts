#!/bin/bash

# Version 3: creates csv from "01Country99"
#!/bin/bash

# Check if a file is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename=$1

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

# Create a temporary file to store the modified content
tempfile=$(mktemp)

# Loop through each line in the file
while IFS= read -r line; do
    # Use sed to insert commas between the three elements
    modified_line=$(echo "$line" | sed 's/\([0-9]\+\)\([A-Za-z ]*\)\([0-9]\+\)/\1,\2,\3/')
    echo "$modified_line" >> "$tempfile"
done < "$filename"

# Overwrite the original file with the modified content
mv "$tempfile" "$filename"

echo "Commas inserted successfully in $filename"


# #!/bin/bash

# Version 2: Creates csv from "Country01"
# # Check if a file is provided as an argument
# if [ $# -eq 0 ]; then
#     echo "Usage: $0 <filename>"
#     exit 1
# fi

# filename=$1

# # Check if the file exists
# if [ ! -f "$filename" ]; then
#     echo "File not found: $filename"
#     exit 1
# fi

# # Create a temporary file to store the modified content
# tempfile=$(mktemp)

# # Loop through each line in the file
# while IFS= read -r line; do
#     # Use sed to insert a comma between the noun and the number
#     modified_line=$(echo "$line" | sed 's/\([A-Za-z]\)\([0-9]\)/\1,\2/')
#     echo "$modified_line" >> "$tempfile"
# done < "$filename"

# # Overwrite the original file with the modified content
# mv "$tempfile" "$filename"

# echo "Commas inserted successfully in $filename"



# #!/bin/bash

# Version 1: creeates spaces from Country01
# # Check if a file is provided as an argument
# if [ $# -eq 0 ]; then
#     echo "Usage: $0 <filename>"
#     exit 1
# fi

# filename=$1

# # Check if the file exists
# if [ ! -f "$filename" ]; then
#     echo "File not found: $filename"
#     exit 1
# fi

# # Create a temporary file to store the modified content
# tempfile=$(mktemp)

# # Loop through each line in the file
# while IFS= read -r line; do
#     # Use sed to insert a space between the noun and the number
#     modified_line=$(echo "$line" | sed 's/\([A-Za-z]\)\([0-9]\)/\1 \2/')
#     echo "$modified_line" >> "$tempfile"
# done < "$filename"

# # Overwrite the original file with the modified content
# mv "$tempfile" "$filename"

# echo "Spaces inserted successfully in $filename"
