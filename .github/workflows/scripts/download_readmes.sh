#!/bin/bash

# Loop JSON and get languages
# -r for raw. (Removes quotes around strings)
# capitalises the language also.
jq -c -r '( .NAME + " " + .REPO + " " + .URL + " " + .LANG + " " + .DATE + " " + .READ )' ./repos.json | while read name repo url lang date readme; do

    echo "${name}"

    # Skip if already exists
    if [[ ! -f "./${name}" ]]; then
        ## Make a directory
        mkdir -p ${name}
    fi
    
    cd ${name}

    ## File doesn't exist, so create it.
    if [[ ! -f "./index.mdx" ]]; then
    
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

    else
        # Keep Frontmatter already set. 
        # May have been manually changed, so don't alter it.
        head -n 7 index.mdx > frontmatter.md && mv frontmatter.md index.mdx
        /usr/bin/curl -qs "${readme}" -O readme.md
        cat README.md >> index.mdx

    fi

    # Clean up Readme.
    rm README.md

    ## Move back out of folder
    cd ..

done