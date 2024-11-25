# Below command is used to generate the model Dto files.
# After adding every new file or for every changes in existing files. Need to run this file.

#!/bin/sh

# Navigate to the project root directory (assumes script is in a subdirectory)
cd "$(dirname "$0")/.." || exit

dart run build_runner build --delete-conflicting-outputs
