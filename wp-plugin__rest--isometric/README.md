# REST Isometric

This is a small shortcode to display anisometric view of images from the latest REST endpoint images.

## Deploy

If the site is not picking up the JSON and images delete the transients:

```
sudo -u www-data wp transient list
sudo -u www-data wp transient delete labsrest-blog
sudo -u www-data wp transient delete labsrest-demonstration
sudo -u www-data wp transient delete labsrest-tutorial
sudo -u www-data wp transient delete labsstack
```

## Changelog

v0.1 - 