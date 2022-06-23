# Footer Selector

## Dependencies
ACF Plugin.

## Usage
The plugin will give you a new menu option 'Footer Selector' that will allow you to choose a specific page for a footer. The contents of this page will be output to the footer template file.

## Details

The footer PHP file will need to grab the ID selected and output it. This is done with the following code:

```
    //  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    //  ┃                                                                         ┃
    //  ┃                     See ANDYP_FOOTER_SELECT Plugin                      ┃
    //  ┃                                                                         ┃
    //  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
    $content_post = get_post( get_field('footer_page', 'option') );
    if ($content_post != ''){
        $content = $content_post->post_content;
        $content = apply_filters('the_content', $content);
        $content = str_replace(']]>', ']]&gt;', $content);
        echo $content;
    } else {
        echo 'Copyright 2020, LondonParkour.com';
    }
```

This simply requests the selected page ID and uses that ID on the get_post() function.

# Visual Bakery

To output the contents of a page builder page, you need a little extra.

First, create a function to get the CSS.
```
    function vc_custom_css($id) {
        $shortcodes_custom_css = get_post_meta( $id, '_wpb_shortcodes_custom_css', true );
        if ( ! empty( $shortcodes_custom_css ) ) {
            echo '<style type="text/css">';
            echo $shortcodes_custom_css;
            echo '</style>';
        }
    }
```
Then you need to call the Visual Composer content and run a do_shortcode() on it.
```
    //  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    //  ┃                                                                         ┃
    //  ┃                     See ANDYP_FOOTER_SELECT Plugin                      ┃
    //  ┃                                                                         ┃
    //  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
    
    $id = get_field('footer_page', 'option');
    $content_post = get_post( $id );

    if ($content_post != ''){
        vc_custom_css($id);
        echo do_shortcode( get_post_field('post_content', $id) );
        
    } else {
        echo 'Copyright 2020, LondonParkour.com';
    }
```
This will then output the content and append the correct CSS included too.


## Changelog

v1.0.0 - Initial Release