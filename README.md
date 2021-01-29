# Creative Embedded Systems: Module 1 (Generative Art)

This project contains a processing script and a python script and is meant to be run on a Raspberry Pi with an LED ring module connected. The generated art is meant to mimic ice melting as water levels rise, both of which relate to global warming. A video of the generative art can be viewed on YouTube: https://www.youtube.com/watch?v=bYVhDSd7Jqo&feature=youtu.be

# Dependencies
This project requires Processing to run. You can download this by copying and pasting the following command into the terminal:

`curl https://processing.org/download/install-arm.sh | sudo sh`

More information about running Processing on Pi can be found here: https://pi.processing.org/download/

This project also makes calls to two web apis and uses the Python 'requests' module to do this. Before starting the Python script, run:

`pip install requests`

# APIs
This project uses two web APIs. The API keys are included in the source code in this repo. If you would like to generate your own API keys you may do so by signing up for a free accounts at the following two sites.  
Open Weather Map: https://openweathermap.org/api Once you have made a free account, replace the key after id=... with your key in the API call in line 31 of rpi_hw1.py 

Visual Crossing: https://www.visualcrossing.com/weather-api Once you have made a free account, replace the key after key=... with your key in the API call in line 40 of rpi_hw1.py 

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
