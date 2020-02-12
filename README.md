# rpi-screensaver-backlight
Control the backlight of your Raspberry pi display

I bought myself the official pi display for my raspberry-pi. My intention was to use the combo as a [`homebridge`](https://github.com/nfarina/homebridge)/`homekit` server in my camping van. Therefore the power consumption should be as low as possible.

### The display

The most potential for saving power is of course the display. So, I've set the screensaver to `Blank`. Unfortunately the backlight of the display kept on sucking the battery of my bus although the screensaver was active.

Since I could not find a screensaver-option to do the trick ... I consulted google and found out that I was able to control the backlight like this

`sudo sh -c 'echo 1 > /sys/class/backlight/rpi_backlight/bl_power'`

`sudo sh -c 'echo 0 > /sys/class/backlight/rpi_backlight/bl_power'`

Curiously, echo'ing a 1 to _bl_power_ turns the display off. Echo'ing a 0 turns it on. But hey, that was enough information to knit something on Linux (instead of Windows as I'm used to).

First we add everybody's read/write access to the device-anchor to get rid of the need to use `sudo`

`echo 'SUBSYSTEM=="backlight",RUN+="/bin/chmod 666 /sys/class/backlight/%k/bl_power"' | sudo tee -a /etc/udev/rules.d/backlight-permissions.rules`

Then we copy the file `screensaver-backlight.pl` of this repository to our folder `/usr/bin` and assign execute access

`sudo chmod a+x /usr/bin/screensaver-backlight.pl`

Finally we enable the auto-execution of the perl-script by modifying the _autostart_ config-file located beyond our home folder

`cd ~/.config/lxsession/LXDE/`

`nano autostart`

We add a new entry `@screensaver-backlight.pl &` somewhere behind the entry of `xscreensaver`

Reboot the pi afterwards. That's it - now the backlight turns on/off together with screensaver's blank screen. If you want to apply above steps on your own raspi you should be aware to do this at your own risk.

## License
MIT License
