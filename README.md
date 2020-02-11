# rpi-screensaver-backlight
Control the backlight of your Raspberry pi

I bought myself the official pi display for my raspberry-pi. My intention was to use them as a homebridge/homekit server in my camping bus. Therefore the power consumption should be as low as possible.

### The display

The most potential for saving power is of course the display. So, I've set the screensaver to `Blank`. Unfortunately the backlight of the display kept on sucking the battery of my bus although the screensaver was active.

Since I could not find an option to do the trick ... I tried google and found out that I was able to control the backlight like this

`sudo sh -c 'echo 1 > /sys/class/backlight/rpi_backlight/bl_power'`

`sudo sh -c 'echo 0 > /sys/class/backlight/rpi_backlight/bl_power'`

Curiously, echo'ing a 1 to bl_power turns the display off. Echo'ing a 0 turns it on.
