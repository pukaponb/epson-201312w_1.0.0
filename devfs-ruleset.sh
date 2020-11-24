#!/bin/sh
# Custom ruleset for jails

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

RULESET=1000
CUPS_GID=193
PRINTER_NAME="EPSON EPSON L1800 Series Series"

# Find the printer device.
UGEN_DEV=$(usbconfig | grep "$PRINTER_NAME" | cut -d':' -f 1)
USB_DEV=$(readlink /dev/$UGEN_DEV)

if [ -z "$UGEN_DEV" -o -z "$USB_DEV" ]
then
  echo "error: cannot find printer '$PRINTER_NAME'"
  echo "error: please check with usbconfig"
  exit 1
fi

echo "Found $PRINTER_NAME on $UGEN_DEV"

# Clean the ruleset
    devfs rule -s $RULESET delset

    # Include jails default ruleset and unhide USB device.
devfs rule -s $RULESET add include 5
devfs rule -s $RULESET add path usb unhide
devfs rule -s $RULESET add path $USB_DEV mode 660 group $CUPS_GID unhide
devfs rule -s $RULESET add path $UGEN_DEV mode 660 group $CUPS_GID unhide
devfs rule -s $RULESET add path usbctl mode 644 unhide