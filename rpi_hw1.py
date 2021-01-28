from datetime import datetime, timedelta
import time
import requests, json
import board
import neopixel

pixel_pin = board.D21
num_pixels = 8
ORDER = neopixel.RGB
 
pixels = neopixel.NeoPixel(
    pixel_pin, num_pixels, brightness=0.2, auto_write=False, pixel_order=ORDER
)

def tempDiff(curr, past):
    r = g = b = 0
    if abs(curr - past) < 1:
        r = 170
        g = 255
        b = 170
    elif curr > past:
        r = 255
        g = 170
        b = 170
    else:
        r = 170
        g = 170
        b = 255

    return (r, g, b, 0)

def getCurrTemp():
    resp = requests.get("http://api.openweathermap.org/data/2.5/weather?id={API_key}")
    currWeather = resp.json()
    temp = currWeather['main']['temp']
    return (temp - 273.15)*(9/5) + 32

def getPastTemp(day, hour):
    nextDay = day + timedelta(days=1)
    day = day.strftime("%Y-%m-%d")
    nextDay = nextDay.strftime("%Y-%m-%d")
    resp = requests.get("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/weatherdata/history?aggregateHours=1&combinationMethod=aggregate&startDateTime="+day+"T00%3A00%3A00&endDateTime="+nextDay+"T00%3A00%3A00&maxStations=-1&maxDistance=-1&contentType=json&unitGroup=us&locationMode=single&key={KEY}&dataElements=default&locations=Brooklyn%2C%20NY")
    pastData = resp.json()
    return pastData['location']['values'][hour]['temp']

 
 
while True:

    yearAgo = datetime.now()
    yearAgo = yearAgo.replace(year=yearAgo.year-1)

    currTime = datetime.now().strftime("%H:%M:%S").split(":")
    hours = int(currTime[0])
    minutes = int(currTime[1])

    curr = getCurrTemp()
    past = getPastTemp(yearAgo, hours)

    colors = tempDiff(curr, past)
    pixels.fill((colors))
    pixels.show()


    if (minutes != 0):
        print("waiting until hour")
        time.sleep(int(minutes) * 60)
    

    else:
        print("sleeping hour")
        time.sleep(3600)



# date without time: https://stackoverflow.com/questions/31758329/create-date-in-python-without-time
# using apis: https://github.com/arocho/generative-art-workshop/blob/master/src/pc_ws/pc_ws.pyde
