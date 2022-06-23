# OAUTH Google YouTube Implementation Plugin.

For Wordpress and ACF.

More info on the oAuth process here: https://ioroot.com/wordpress-oauth-and-ajax/  

## Dependencies
- [google-api-php-client](https://github.com/googleapis/google-api-php-client)
- google-api-php-client-services


More info at:                                                           
- https://dev.to/ioroot/google-oauth-wordpress-youtube-service-api-4ko6    
- https://ioroot.com/wordpress-oauth-and-ajax/                             
- https://github.com/IORoot/wp-plugin__oauth-demo        


## Credentials 
1. Make sure that you have downloaded the crendials json file from the google api console.
1. Saved it in the root of the project called client_secret.json
1. The .gitignore is listing that file (so you don't add it to git!)
1. `define('YOUTUBE_GOOGLE_APPLICATION_CREDENTIALS', __DIR__.'/client_secret.json');`



## Troubleshooting

### OAUTH Issues


1. Ensure HTTPS is working. (Make sure cert is created and added to keychain)


2. Ensure the address of the `Authorised redirect URIs` has the correct URIs in it's list.
```
https://dev.exporter.londonparkour.com/wp-admin/admin-ajax.php
```
Preferably at the top of the list.

3. Ensure `Authorised JavaScript origins` in the google console APIs 'credentials' has the 
domain:
```
https://dev.exporter.londonparkour.com
```