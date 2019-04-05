#!/bin/python
import math
from time import sleep
import sys
from time import localtime, strftime

def getI3Json(inputText, shortText = None, textColor = '#ffffff', backgroundColor = '#222222', borderColor = '#222222', minWidth = None, align = 'right', urgent = False, separator = False, separator_block_width = 0):
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
		if value:
			text = text + 'true'
		else:
			text = text + 'false'
	elif isinstance(value, int):
		text = text + str(value)
	if printComma:
		text = text + ', '
	return text

def updateText(conkyFile):
	lines = conkyFile.readlines()
	
	if len(lines) >= 82:
		time=lines[0]
		date=lines[1]
		systeminfotext=lines[2]
		systemtext=lines[3]
		systemname=lines[4]
		uptimetext=lines[5]
		uptime=lines[6]
		kernaltext=lines[7]
		kernal=lines[8]
		ostext=lines[9]
		os=lines[10]
		frequencytext=lines[11]
		frequency=lines[12]
		mactext=lines[13]
		mac=lines[14]
		cputext=lines[15]
		loadavgtext=lines[16]
		avgnumber=lines[17]
		cpu0text=lines[18]
		cpu0=lines[19]
		cpu1text=lines[20]
		cpu1=lines[21]
		cpu2text=lines[22]
		cpu2=lines[23]
		cpu3text=lines[24]
		cpu3=lines[25]
		Memoryswaptext=lines[26]
		ramusagetext=lines[27]
		ramusage=lines[28]
		rampercentage=lines[29]
		memoryswaptext=lines[30]
		memoryswap=lines[31]
		memorypercentage=lines[32]
		filesystemtext=lines[33]
		filesystemname=lines[34]
		filesystemsize=lines[35]
		filesystempercentage=lines[36]
		readstext=lines[37]
		readspersec=lines[38]
		writestext=lines[39]
		writespersec=lines[40]
		networkingtext=lines[41]
		wifiip=lines[42]
		downtext=lines[43]
		downpersec=lines[44]
		uptext=lines[45]
		uppersec=lines[46]
		downtotaltext=lines[47]
		downtotal=lines[48]
		uptotaltext=lines[49]
		uptotal=lines[50]
		empty=lines[51]
		topreasurcestext=lines[52]
		processestext=lines[53]
		numberprocesses=lines[54]
		runningtext=lines[55]
		runningnumber=lines[56]
		cpuusagetext=lines[57]
		tableheader=lines[58]
		top1cpu=lines[59]
		top2cpu=lines[60]
		top3cpu=lines[61]
		memusagetext=lines[62]
		memheader=lines[63]
		top1mem=lines[64]
		top2mem=lines[65]
		top3mem=lines[66]
		systemstatstext=lines[67]
		volumetext=lines[68]
		volumeicon=lines[69]
		volume=lines[70]
		brightnesstext=lines[71]
		brigthnessicon=lines[72]
		brigthness=lines[73]
		capslocktext=lines[74]
		capslockicon=lines[75]
		capslock=lines[76]
		batterytext=lines[77]
		batteryicon=lines[78]
		battery=lines[79]
		temperaturetext=lines[80]
		temperatureicon=lines[81]
		temperature=lines[82]

		print(',[')
		print(getI3Json(inputText = volumeicon))
		print(',')
		print(getI3Json(inputText = volume, separator = True, separator_block_width = 12))
		print(',')
		print(getI3Json(inputText = brigthnessicon))
		print(',')
		print(getI3Json(inputText = brigthness, separator = True, separator_block_width = 12))
		print(',')
		print(getI3Json(inputText = capslockicon))
		print(',')
		print(getI3Json(inputText = capslock, separator = True, separator_block_width = 12))
		print(',')
		print(getI3Json(inputText = wifiip, separator = True, separator_block_width = 12))
		print(',')
		print(getI3Json(inputText = temperatureicon))
		print(',')
		print(getI3Json(inputText = temperature, separator = True, separator_block_width = 12))
		print(',')		
		print(getI3Json(inputText = batteryicon))
		print(',')
		print(getI3Json(inputText = battery, separator = True, separator_block_width = 12))
		print(',')
		print(getI3Json(inputText = strftime("%w %B %Y %H:%M:%S", localtime()), separator = True, separator_block_width = 12))
		print(']')
		sys.stdout.flush()

print('{ "version": 1 }')
print('[')
print('[]')

while True:
	try:
		conkyFile = open("/tmp/conkyout.txt", "r")
		updateText(conkyFile)
	except (FileNotFoundError, IOError) as e:
		print('',end = '')
	finally:
		sleep(1)
