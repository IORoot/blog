#!/bin/bash

# Loop JSON and get languages
# -r for raw. (Removes quotes around strings)
# capitalises the language also.
jq -c -r '( .NAME + " " + .REPO + " " + .URL + " " + .DATE + " " + .READ + " " + .LANG)' ./repos.json | while read name repo url date readme lang; do

    echo "${name}"

    # Skip if already exists
    if [[ ! -f "./${name}" ]]; then
        ## Make a directory
        mkdir -p ${name}
    fi
    
    cd $name

    # Download Readme
    
    /usr/bin/curl -qs "${readme}" -O readme.md

    # Cleanup IMG tags
    cat README.md | perl -pe 's|(<img.*?)>|$1/>|' | perl -pe 's|//>|/>|' > README_PERL.md && mv README_PERL.md README.md


    ## File doesn't exist, so create it.
    if [[ ! -f "./index.mdx" ]]; then
    
        ## convert date "2022-06-13T17:04:18Z" to "2022-06-13"
        yyyymmdd=$(echo $date | cut -d 'T' -f 1)

        ## Cleanup slug.
        slug="${name,,}"    # lowercase
        slug="${slug/./-}"  # dots for dash

        ## Prefix Frontmatter
        echo "---" > index.mdx
        echo "repo: \"${url}\"" >> index.mdx
        echo "slug:  \"/projects/${slug}\"" >> index.mdx
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

    ## Append the REPO if missing
    REPO_FIELD=$(grep "^repo.*" index.mdx)
    if [ -z "$REPO_FIELD" ]; then
        echo "---"  > repo.mdx
        echo "repo: \"${url}\"" >> repo.mdx
        tail -n +2 index.mdx >> repo.mdx
        mv -f repo.mdx index.mdx
    fi

    # Clean up Readme.
    rm README.md

    ## Move back out of folder
    cd ..

done