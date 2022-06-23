# Page Builder

Built upon ACF Pro, this is an alternative wordpress page-builder without all the injected extra code
you have no idea the developer has deemed nessesary.

A light-weight solution that enables you to build pages the way you want to - with no constraints.

This is the base module that requires other plugins to run. For instance, the `rawcode` plugin will allow
you to inject any code you want directly onto the page.

The beauty of it is that it allows you to create an organised foldered structure for your sections by using
ACFs 'repeaters' and 'clones'.

## Use-case

Built with tailwind-css and SVGs as imagery in mind, this builder was created to allow me to keep the page 
sizes to a minimum for good lighthouse scores. 

The page builder really only does the following things:

1. Gives you access to the other page-builder plugins to place onto the page.
2. Add classes into the body or page. (optional)
3. Add code into the Header
4. Add code into the Footer
5. Add SVGs into the Footer
6. Import and Export JSON representation of the page. 
7. Import and Export JSON representation of the SVGs. 

The import/export functionality allows you to copy & paste the page or SVG data all in one.

## Requirements

- Wordpress
- ACF Pro

## Install

Note: This plugin WILL disable the normal WYSIWYG builder you would normally see.

### Header

Your theme will need to include the following code into the header, below the `wp_head();` function.

```php
<?php 
    wp_head(); 
    do_action('page_builder_header_code'); 
?>
```
This is so the plugin can inject any code you specify (CSS / Stylesheets) into the header.

### Footer

Similarly, the theme footer will require the following code, just ABOVE the `wo__footer();` function.

```php
<?php 
    do_action('page_builder_footer_code'); 
    wp_footer(); 
?>
```

This is for any SVGs to reference or Javascript to inject.


## Changelog

v1.0.0 - Initial Release