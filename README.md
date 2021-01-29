# Creative Embedded Systems: Module 1 (Generative Art)

This project contains a processing script and a python script and is meant to be run on a Raspberry Pi with an LED ring module connected.

# Dependencies
This project requires Processing to run. You can download this by copying and pasting the following command into the terminal:
`curl https://processing.org/download/install-arm.sh | sudo sh`
More information about running Processing on Pi can be found here: https://pi.processing.org/download/

This project also makes calls to two web apis and uses the Python 'requests' module to do this. Before starting the Python script, run:
`pip install requests`

# Running on boot
Both the processing script and a python script that controls the LED module run on boot.
To run the python script on boot, first type into the command line:
`sudo nano /etc/rc.local`

Once you are within rc.local, add the following to the bottom of the file (before exit 0):
`sudo python3 /home/pi/rpi_hw.py`

To set up the processing script to run on boot, first access the autostart file. On Raspbian 10 this can be found by typing the following into the command line:
`sudo nano /etc/xdg/lxsession/LXDE-pi/autostart`
Now within the file, add the following to the end of the file:

`/usr/local/bin/processing-java --sketch=/home/pi/Documents/ice_melting --run`

note that ice_melting must be stored in Documents. If it is not stored there remove /Documents from the path
