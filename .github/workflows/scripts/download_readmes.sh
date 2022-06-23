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

    # Download Readme
    /usr/bin/curl -qs "${readme}" -O readme.md

    # Cleanup IMG tags
    cat README.md | perl -pe 's|(<img.*?)>|$1/>|' > README_PERL.md && mv README_PERL.md README.md


    ## File doesn't exist, so create it.
    if [[ ! -f "./index.mdx" ]]; then
    
        ## convert date "2022-06-13T17:04:18Z" to "2022-06-13"
        yyyymmdd=$(echo $date | cut -d 'T' -f 1)

        ## Prefix Frontmatter
        echo "---" > index.mdx
        echo "slug:  \"/projects/${name}\"" >> index.mdx
        echo "date:  \"$yyyymmdd\"" >> index.mdx
        echo "title: \"${name}\"" >> index.mdx
        echo "icon:  \"$lang\"" >> index.mdx
        echo "---" >> index.mdx
        printf "\n\n" >> index.mdx
        cat README.md >> index.mdx

    else
        # Keep Frontmatter already set. 
        # May have been manually changed, so don't alter it.
        head -n 7 index.mdx > frontmatter.md && mv frontmatter.md index.mdx
        cat README.md >> index.mdx

    fi

    # Clean up Readme.
    rm README.md

    ## Move back out of folder
    cd ..

done