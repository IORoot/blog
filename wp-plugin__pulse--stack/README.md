# Pulse Stack

This is a small shortcode to display a "stack" of images from the latest ParkourPulse images.

## Deploy issues

```
sudo -u www-data wp transient list
sudo -u www-data wp transient delete pulserest-pulse
sudo -u www-data wp transient delete pulsestack
```