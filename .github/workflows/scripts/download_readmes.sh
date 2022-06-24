#!/bin/bash

# Username:Password
GHUSER=IOROOT;
PAT=$1;

# Loop JSON and get languages
# -r for raw. (Removes quotes around strings)
# capitalises the language also.
IFS="~"

jq -c -r '( .NAME + "~" + .REPO + "~" + .URL + "~" + .DATE + "~" + .READ + "~" + .LANG + "~" + .TAGS + "~" + .DESC )' ./repos.json | while read name repo url date readme lang tags desc; do

    # echo "${name}"
    # echo "${repo}"
    # echo "${url}"
    # echo "${date}"
    # echo "${readme}"
    # echo "${lang}"
    # echo "${desc}"
    echo "${tags}"

    # Skip if already exists
    if [[ ! -f "./${name}" ]]; then
        ## Make a directory
        mkdir -p ${name}
    fi
    
    cd $name

    # Download Readme
    
    /usr/bin/curl -u ${GHUSER}:${PAT} -qs "${readme}" -O readme.md > /dev/null

    # Cleanup IMG tags
    cat README.md | perl -pe 's|(<img.*?)>|$1/>|' | perl -pe 's|//>|/>|' > README_PERL.md && mv README_PERL.md README.md


    ## File doesn't exist, so create it.
    if [[ ! -f "./index.mdx" ]]; then
    
        ## convert date "2022-06-13T17:04:18Z" to "2022-06-13"
        yyyymmdd=$(echo $date | cut -d 'T' -f 1)

        ## Cleanup slug.
        slug="${name,,}"    # lowercase
        slug="${slug/./-}"  # dots for dash

        ## If icon is null, default to github
        if [ $lang == "null" ]; then
                lang="github"
        fi

        ## Prefix Frontmatter
        echo "---" > index.mdx
        echo "repo: \"${url}\"" >> index.mdx
        echo "slug:  \"/projects/${slug}\"" >> index.mdx
        echo "date:  \"$yyyymmdd\"" >> index.mdx
        echo "title: \"${name}\"" >> index.mdx
        echo "icon:  \"$lang\"" >> index.mdx
        echo "desc:  \"$desc\"" >> index.mdx
        echo "tags:  \"$tags\"" >> index.mdx
        echo "---" >> index.mdx
        printf "\n\n" >> index.mdx
        cat README.md >> index.mdx

    else
        # Keep Frontmatter already set. 
        # May have been manually changed, so don't alter it.
        head -n 9 index.mdx > frontmatter.md && mv frontmatter.md index.mdx
        cat README.md >> index.mdx
    fi

    # Clean up Readme.
    rm README.md

    ## Move back out of folder
    cd ..

done