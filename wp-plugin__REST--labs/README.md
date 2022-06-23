# Labs Stack

This is a small shortcode to display a "stack" of images from the latest ParkouLabs images.

## Deploy

If the site is not picking up the JSON and images delete the transients:

```
sudo -u www-data wp transient list
sudo -u www-data wp transient delete labsrest-blog
sudo -u www-data wp transient delete labsrest-demonstration
sudo -u www-data wp transient delete labsrest-tutorial
sudo -u www-data wp transient delete labsstack
```