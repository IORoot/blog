# Menus Extended

Adds ACF options into the menus. Allows youu to attach icons and images to menu items.

# Config
Create two menus called "Main Menu" and "Sub Menu" to hook into the custom menu-walkers.

# Output the menus
To output the main menu correctly, you must use the code:
```php
    wp_nav_menu([
        'theme_location'  => 'menu-1',
        'menu_id'         => 'main-menu',
        'container_class' => 'flex-1 z-50',
        'menu_class'      => 'flex justify-center text-center',
        'walker'          => new MainMenu_Walker,
        'before'          => '',
        'link_before'     => '',
        'after'           => '',
    ]);
```

for the sub-menu:
```php
    wp_nav_menu([
        'theme_location'  => 'sub-menu',
        'menu_id'         => 'sub-menu',
        'container_class' => 'flex-1',
        'menu_class'      => 'flex justify-start text-center',
        'walker'          => new SubMenu_Walker,
        'before'          => '',
        'link_before'     => '',
        'after'           => '',
    ]);
```
See the `examples` folder.

# CSS
For the show/hide functionality of the sub-menus you need to include the following CSS. (PostCSS / SASS)

```css
/* SASS */
header nav div #main-menu {
    /* For hovering */
    & > ul:hover > div,
    & > li:hover > div {
        display: block;
    }

    & > ul:hover > ul, 
    & > li:hover > ul {
        display: block; 
    } 
}
```

## Changelog

v1.3.0 - Add menu walkers for main-menu and sub-menu

v1.2.1 - Add ACF Panel back in.

v1.2.0 - Updated help, examples and layout.

v1.1.0 - Add fullwidth items on admin menu.

v1.0.0 - Initial Release.