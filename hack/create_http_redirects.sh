#!/bin/bash

# 1. Capture the version from the first argument
VERSION=$1

# 2. Check if a version was provided
if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.28"
    exit 1
fi

# 3. Define paths relative to this script's location
# $(dirname "$0") is the 'hack' folder. /.. moves up to the root.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
BASE_DIR="$ROOT_DIR/assets/documentation/$VERSION"
BASE_URL="https://cloudnative-pg.io/docs/$VERSION"

# Special handling of "current"
if [ $VERSION = "current" ]
then
     BASE_URL="https://cloudnative-pg.io/docs/devel"
fi

# The message displayed to users
MSG_TITLE="CloudNativePG documentation has moved"
MSG_BODY="CloudNativePG has changed the way we build and organize our documentation to provide a better experience."

# 4. Check if the target directory exists
if [ ! -d "$BASE_DIR" ]; then
    echo "Error: Directory not found at $BASE_DIR"
    echo "Make sure you are passing the correct version and the assets folder exists."
    exit 1
fi

echo "Searching for index.html files in: $BASE_DIR"

# 5. Find and process files
find "$BASE_DIR" -type f -name "index.html" | while read -r file; do

    # Calculate the slug
    # We strip the absolute path to the base directory to get the relative piece
    rel_path=${file#"$BASE_DIR/"}
    
    # Remove the filename suffix (/index.html)
    slug=${rel_path%/index.html}

    # Handle the root index.html case
    if [ "$slug" == "index.html" ]; then
        new_url="$BASE_URL"
    else
        new_url="$BASE_URL/$slug"
    fi

    echo "Updating: assets/documentation/$VERSION/$rel_path"
    echo "      -> $new_url"

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
echo "Success: All files in $VERSION updated from the hack folder."
