#!/bin/sh
# Use this cmd : ./file-creation.sh [FEATURENAME]

# ex: ./feature_directory_generator.sh login

# Check if an argument is provided
if [ $# -eq 0 ]; then
  echo "Please provide a feature name."
  exit 1
fi

# Set the base directory to the project root by going one level up from the current script directory
BASE=$(dirname "$(pwd)")

FEATURE_NAME=$1
BASE_LIB_DIR="$BASE/lib/features/$FEATURE_NAME"
#BASE_TEST_DIR="$BASE/test/features/$FEATURE_NAME"

# Declare the subdirectories
SUBDIRECTORIES=(
    "data"
    "data/data_mapper"
    "data/repository"
    "data/models"

    "domain"
    "domain/entity"
    "domain/repository"
    "domain/usecase"

    "presentation"
    "presentation/providers"
)

# Declare the files in each directory
SUBFILES=(
    "data/data_mapper/${FEATURE_NAME}_data_mapper"
    "data/repository/${FEATURE_NAME}_repository_impl"
    "data/models/${FEATURE_NAME}_response_dto"

    "domain/entity/${FEATURE_NAME}_entity"
    "domain/repository/${FEATURE_NAME}_repository"
    "domain/usecase/${FEATURE_NAME}_usecase"

    "presentation/${FEATURE_NAME}_screen"
    "presentation/providers/${FEATURE_NAME}_provider"
)

for BASE_DIR in $BASE_LIB_DIR $BASE_TEST_DIR; do
  mkdir -p $BASE_DIR

  for SUBDIR in "${SUBDIRECTORIES[@]}"; do
    mkdir -p "$BASE_DIR/$SUBDIR"
  done

  for SUBFILE in "${SUBFILES[@]}"; do
    if [ "$BASE_DIR" == "$BASE_TEST_DIR" ]; then
      touch "$BASE_DIR/${SUBFILE}_test.dart"
    else
      touch "$BASE_DIR/${SUBFILE}.dart"
    fi
  done

done

echo "Feature structure created for $FEATURE_NAME in both lib and test folders."