#!/bin/bash

# 1. Capture the version from the first argument
INPUT_VERSION=$1

# 2. Check if a version was provided
if [ -z "$INPUT_VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.28"
    echo "Example: $0 current"
    exit 1
fi

# 3. Handle specific redirection mapping logic
if [ "$INPUT_VERSION" == "current" ]; then
    # Map 'current' to 'devel'
    DEST_VERSION="devel"
elif [[ "$INPUT_VERSION" =~ -rc[0-9]+$ ]]; then
    # Extract only Major.Minor (e.g., 1.27.0-rc1 -> 1.27)
    # This regex looks for the first two number groups separated by a dot
    DEST_VERSION=$(echo "$INPUT_VERSION" | sed -E 's/^([0-9]+\.[0-9]+).*/\1/')
else
    # Keep as is (e.g., 1.28 -> 1.28)
    DEST_VERSION="$INPUT_VERSION"
fi

# 4. Define paths relative to this script's location
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
BASE_DIR="$ROOT_DIR/assets/documentation/$INPUT_VERSION"
BASE_URL="https://cloudnative-pg.io/docs/$DEST_VERSION"

# The message requested
MSG_TITLE="CloudNativePG documentation has moved"
MSG_BODY="CloudNativePG has changed the way we build and organize our documentation to provide a better experience."

# 5. Check if the target directory exists
if [ ! -d "$BASE_DIR" ]; then
    echo "Error: Directory not found at $BASE_DIR"
    exit 1
fi

echo "Source Version: $INPUT_VERSION"
echo "Target URL Version: $DEST_VERSION"
echo "Searching for index.html files..."

# 6. Find and process files
find "$BASE_DIR" -type f -name "index.html" | while read -r file; do

    # Calculate the slug
    rel_path=${file#"$BASE_DIR/"}
    slug=${rel_path%/index.html}

    # Handle the root index.html case
    if [ "$slug" == "index.html" ]; then
        new_url="$BASE_URL"
    else
        new_url="$BASE_URL/$slug"
    fi

    # Overwrite the file
    cat <<EOF > "$file"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="0; url=$new_url">
    <title>Redirecting to CloudNativePG Docs...</title>
</head>
<body>
    <h1>$MSG_TITLE</h1>
    <p>$MSG_BODY</p>
    <p>If you are not automatically redirected, please <a href="$new_url">click here to go to the new page</a>.</p>
</body>
</html>
EOF

done

echo "------------------------------------------------"
echo "Success: All files in $INPUT_VERSION have been updated."
