# Simple login / logout button for memberpress

This little shortcode will create a 'login' button that will change to a 'logout' button if you are logged in.

You can swap the login button to be either a 'login', 'logout' or 'account' button. However it really only makes sense to keep it as the 'login'.

However, the 'logout' button has the same functionality and therefore you may wish to use the 'account' template instead of the 'logout'

## Usage

Simple example

    [login_logout]

Advanced

    [login_logout in="login" out="account"]

## Under the hood

There are three functions in the main class that control the output. The 'login', 'logout' and 'account' methods.

Each one styles the button differently, so you can simply add your own methods and seet the variables as you wish.

## Meemberpress

By default, the plugin will take the memberpress URLs for the login, logout and account pages and put them into the template. You can override this in the methods easily.