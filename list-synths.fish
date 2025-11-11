#!/run/current-system/sw/bin/fish

set temp_json_location "listing.json"
dhall-to-json --file synths.dhall | jq . >$temp_json_location
typst compile listing.typ listing.png --input jsonUri=$temp_json_location
rm $temp_json_location
