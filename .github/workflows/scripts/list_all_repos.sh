#!/bin/bash

# Username
GHUSER=IOROOT;
PAT=$1;

# Grab TWO PAGES of the Repo list from Github API
/usr/bin/curl "https://api.github.com/users/$GHUSER/repos?per_page=100&sort=created&direction=desc" | /usr/bin/jq '.[] | {NAME: .name, REPO: .full_name, URL: .html_url, LANG: ( "https://api.github.com/repos/" + .full_name + "/languages"), DESC: .description, DATE: .created_at, READ: ("https://raw.githubusercontent.com/" + .full_name + "/master/README.md") }  ' > ./repos.json
/usr/bin/curl "https://api.github.com/users/$GHUSER/repos?per_page=100&page=2&sort=created&direction=desc" | /usr/bin/jq '.[] | {NAME: .name, REPO: .full_name, URL: .html_url, LANG: ( "https://api.github.com/repos/" + .full_name + "/languages") , DESC: .description, DATE: .created_at, READ: ("https://raw.githubusercontent.com/" + .full_name + "/master/README.md") }  ' >> ./repos.json


# Loop JSON and get languages
# -r for raw. (Removes quotes around strings)
# capitalises the language also.
jq -r '.LANG' ./repos.json | while read url; do
    /usr/bin/curl -u ${GHUSER}:${PAT} -s "${url}" > languages.json
    repo_language=$(cat languages.json | jq -r 'keys | last(.[])')
    lowercased=${repo_language,,}
    sed -i "s|${url}|${lowercased}|g" ./repos.json
done