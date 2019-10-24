#!/bin/python
import math
from time import sleep
import sys
from time import localtime, strftime
import time
import os
import subprocess
import re 

def getI3Json(inputText, shortText = None, textColor = '#ffffff', backgroundColor = '#07080c', borderColor = '#07080c', minWidth = None, align = 'right', urgent = False, separator = False, separator_block_width = 0):
	text = ''
	text = text + getJsonElement('{"full_text": ', inputText, True)	
	if shortText != None:
		text = text + getJsonElement('"short_text": ', shortText, True)	
	text = text + getJsonElement('"color": ', textColor, True)	
	text = text + getJsonElement('"background": ', backgroundColor, True)	
	text = text + getJsonElement('"border": ', borderColor, True)	
	if minWidth != None:
		text = text + getJsonElement('"min_width": ', minWidth, True)	
	text = text + getJsonElement('"align": ', align, True)	
	text = text + getJsonElement('"urgent": ', urgent, True)	
	if separator_block_width != None:
		text = text + getJsonElement('"separator_block_width": ', separator_block_width, True)
	text = text + getJsonElement('"separator": ', separator, False)
	text = text + '}'
	return text

def getJsonElement(key, value, printComma):
	key=key.strip()
	text = ''
	text = text + key
	if isinstance(value, str):
		value=value.strip()
		text = text + '"' + value + '"'
	elif isinstance(value, bool):
		if value == True:
			text = text + 'true'
		else:
			text = text + 'false'
	elif isinstance(value, int):
		text = text + str(value)
	if printComma:
		text = text + ', '
	return text

def printTime():
	return getI3Json(inputText = strftime("%D %H:%M:%S", localtime()), separator = True, separator_block_width = 12)

def printCpuTemp():
	temp=0.0
	temperatureicon=""
	tempvals=os.popen("sensors | grep Core | awk -F ' ' '{print $3}'").read().split('\n')
	for x in range(0, len(tempvals)-1):
		valueString=tempvals[x]
		temp = temp + float(valueString[1:len(valueString)-2])
	temp=temp/2
	if temp > 80:
		urgent = True
	else:
		urgent = False
	temperature=str(temp) + "°C"
	return getI3Json(inputText = temperatureicon, urgent = urgent) + '\n,\n' + getI3Json(inputText = temperature, urgent = urgent, separator = True, separator_block_width = 12)

def printAvgCpu():
	cpuicon=""
	usages=os.popen("ps -eo pcpu").read().split('\n')
	cpuInt=0
	for x in range(1, len(usages)-1):
		cpuInt=cpuInt+float(usages[x])
	cpuInt=cpuInt/4
	cpu=float("{0:.2f}".format(cpuInt))
	if cpu > 90:
		urgent=True
	else:
		urgent=False 
	return getI3Json(inputText = cpuicon, urgent = urgent) + '\n,\n' + getI3Json(inputText = str(cpu) + '%', urgent = urgent, separator = True, separator_block_width = 12)

def printBattery():
	battery=os.popen('acpi').read()
	batterySplitted=battery.split(" ")
	bat=batterySplitted[3]
	if bat.endswith('\n'):
		bat = bat[0:len(bat)-2]
	if bat.endswith(','):
		bat = bat[0:len(bat)-1]
	if bat.endswith('%'):
		bat = bat[0:len(bat)-1]
	bat=int(bat)
	if bat > 80:
		batteryicon=""
		color='#00ff00'
	elif bat > 60:
		batteryicon="" 
		color='#a8ff00'
	elif bat > 40:
		batteryicon="" 
		color='#fff600'
	elif bat > 20:
		batteryicon=""
		color='#ffae00'
	else:
		batteryicon=""
		color='#ff0000'
	text = str(bat) + '% ' 
	if len(batterySplitted) > 4:				
		timeval=batterySplitted[4]
		textRemaining = "(" + timeval[0:len(timeval)-3] + ")"
		text = text + textRemaining
	if "Discharging" not in battery or "Full" in battery:
		text = text + " "
	return getI3Json(inputText = batteryicon, textColor = color) + '\n,\n' + getI3Json(inputText = text, separator = True, separator_block_width = 12, textColor = color)		

def printWIFI():
	wifiips=os.popen('hostname -i').read().split(" ")
	ip = ""
	if len(wifiips) > 0:
		for wifiip in wifiips:
			if "172.17.0.1" not in wifiip and re.search('(?:\d{3}|\d{2}|\d{1}).(?:\d{3}|\d{2}|\d{1}).(?:\d{3}|\d{2}|\d{1}).(?:\d{3}|\d{2}|\d{1})', wifiip):
				ip="WIFI (" + wifiip + ")"
				textColor='#00ff00'
				break
			else:			
				ip="WIFI (No Address)"
				textColor='#ff0000'
	else:
		ip="WIFI (No Address)"
		textColor='#ff0000'
	return getI3Json(inputText = ip, separator = True, separator_block_width = 12, textColor = textColor)	


def printCaps():
	caps=os.popen('xset -q | grep Caps | cut -d "o" -f 3 | cut -d " " -f 1').read()
	if "n" in caps: 
		return getI3Json(inputText = "", urgent = True) + '\n,\n' + getI3Json(inputText = 'locked', urgent = True, separator = True, separator_block_width = 12)
	else:
		return getI3Json(inputText = "", urgent = False, separator = True, separator_block_width = 12)

def printBrightness():
	brigthnessicon=""
	brigthness=os.popen("xbacklight | cut -d'.' -f 1").read().rstrip()
	brigthness=brigthness + "%"
	return getI3Json(inputText = brigthnessicon) + '\n,\n' + getI3Json(inputText = brigthness, separator = True, separator_block_width = 12)

def printVolume():
	volumeicon=""
	sink=os.popen("pacmd list-sinks | awk '/index:/{i++} /* index:/{print i; exit}'").read().rstrip()
	mute=os.popen("pacmd list-sinks | awk '/^\smuted: /{i++} i=='"+ sink +"'{print $2; exit}'").read()
	volume=os.popen("pacmd list-sinks | awk '/^\svolume: /{i++} i=='"+ sink + "'{print $5; exit}'").read()
	text=""
	if "yes" in mute:
		text = "Mute"
	else:
		text= volume
	return getI3Json(inputText = volumeicon) + "\n,\n" + getI3Json(inputText = text, separator = True, separator_block_width = 12)

volume=printVolume()
brightness=printBrightness()
caps=printCaps()
wifi=printWIFI()
avgCpu=printAvgCpu()
cputemp=printCpuTemp()
battery=printBattery()
currentTime=printTime()

prevMillis=int(round(time.time() * 1000))
counter500=0
counter1000=0
counter2000=0
counter5000=0
sleepTime=1000
def updateValues():
	global counter500
	global counter1000
	global counter2000
	global counter5000
	global volume
	global brightness
	global caps
	global wifi
	global avgCpu
	global cputemp
	global battery
	global currentTime
	global sleepTime
	difference=(int(round(time.time() * 1000)) - prevMillis)
	if int(difference / 500) > counter500:
		counter500=counter500+1
		currentTime=printTime()
		volume=printVolume()
		brightness=printBrightness()
		caps=printCaps()
	if int(difference / 1000) > counter1000:
		counter1000=counter1000+1
		wifi=printWIFI()
		cputemp=printCpuTemp()
		avgCpu=printAvgCpu()
	if int(difference / 2000) > counter2000:
		counter2000=counter2000+1
	if int(difference / 5000) > counter5000:
		counter5000=counter5000+1
		battery=printBattery()
	sleepTime=1000 - (difference%1000)

def updateText():
	print(',[')
	print(volume)
	print(',')
	print(brightness)
	print(',')
	print(caps)
	print(',')
	print(wifi)
	print(',')
	print(avgCpu)
	print(',')
	print(cputemp)
	print(',')
	if battery is not None:
		print(battery)
		print(',')
	print(currentTime)
	print(']')
	sys.stdout.flush()
	
print('{ "version": 1 }')
print('[')
print('[]')

while True:
	updateValues()
	updateText()
	sleep(sleepTime/1000)
