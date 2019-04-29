jq -R '
[inputs
| select(length>0)
| ./ ","
| {"name":.[0],"type":.[1],"mode":.[2],"description":.[3]}
]'
