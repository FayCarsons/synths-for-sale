#!/run/current-system/sw/bin/fish

dhall-to-json --file synths.dhall | jq -r '.[] | "\(.name)|$\(.price)"' | column -t -s '|'
