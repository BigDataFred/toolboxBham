#!/bin/bash


ID=$1 #patient ID

echo "extracting date and times of macro data for ${ID}"

matlab -nodisplay -nodesktop -r "extract_rec_date_and_time('${ID}')"
matlab -nodisplay -nodesktop -r "lookup_macro_files('${ID}')"
