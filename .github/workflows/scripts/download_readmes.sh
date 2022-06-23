#!/bin/bash

# Username
GHUSER=IOROOT;

# Loop JSON and get languages
# -r for raw. (Removes quotes around strings)
# capitalises the language also.
jq -c -r '( .NAME + " " + .REPO + " " + .URL + " " + .LANG + " " + .DATE + " " + .READ )' ./repos.json | while read name repo url lang date readme; do

    ## Make a directory
    mkdir -p ${name}
    
    ## Download readme as index.mdx
    cd ${name}
    /usr/bin/curl -qs "${readme}" -O readme.md
    
    ## Prefix Frontmatter
    echo "---" > index.mdx
    echo "slug:  \"/projects/${name}\"" >> index.mdx
    echo "date:  \"$date\"" >> index.mdx
    echo "title: \"${name}\"" >> index.mdx
    echo "icon:  \"$lang\"" >> index.mdx
    echo "---" >> index.mdx
    printf "\n\n" >> index.mdx
    cat README.md >> index.mdx

    # Clean up Readme.
    rm README.md

    ## Move back out of folder
    cd ..

done