#!/usr/bin/perl

my $blfile = '/sys/class/backlight/rpi_backlight/bl_power';
while (! -e $blfile) {
    sleep(1);
}
my $blanked = 0;
system "xscreensaver-command -display :0.0 -deactivate >/dev/null 2>&1";
system "echo 0 > /sys/class/backlight/rpi_backlight/bl_power";
open (IN, "xscreensaver-command -display :0.0 -watch |");
while (<IN>) {
    if (m/^(BLANK|LOCK)/) {
        if (!$blanked) {
            system "echo 1 > /sys/class/backlight/rpi_backlight/bl_power";
            $blanked = 1;
        }
    } elsif (m/^UNBLANK/) {
        system "echo 0 > /sys/class/backlight/rpi_backlight/bl_power";
        $blanked = 0;
    }
}
