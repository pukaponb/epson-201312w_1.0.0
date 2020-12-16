# Install [Freebsd]
``` bash
$ sed -i -e 's/enabled: no/enabled: yes/' /usr/local/etc/pkg/repos/FreeBSD.conf
$ sed -i -e 's/enabled: yes/enabled: no/' /usr/local/etc/pkg/repos/local.conf
$ pkg install cups nano gutenprint wget
```


## devfs use Rule id 1000
```
100 path usb unhide
200 path usb/0.2.0 unhide group 193 mode 660
300 path ugen0.2 unhide group 193 mode 660
400 path usbctl unhide mode 644
```