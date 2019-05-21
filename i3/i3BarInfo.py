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
	print(getI3Json(inputText = strftime("%D %H:%M:%S", localtime()), separator = True, separator_block_width = 12))

def printCpuTemp(lines):
	temperatureicon=lines[79]
	temperature=lines[80]
	temp=temperature[1:len(temperature)-5]
	if int(temp) > 80:
		urgent = True
	else:
		urgent = False
	print(getI3Json(inputText = temperatureicon, urgent = urgent))
	print(',')
	print(getI3Json(inputText = temperature, urgent = urgent, separator = True, separator_block_width = 12))

def printAvgCpu(lines):
	cpu0=lines[20]
	cpu1=lines[22]
	cpu2=lines[24]
	cpu3=lines[26]
	cpuicon=lines[17]
	cpu0=cpu0[0:len(cpu0)-3]
	cpu1=cpu1[0:len(cpu1)-3]
	cpu2=cpu2[0:len(cpu2)-3]
	cpu3=cpu3[0:len(cpu3)-3]
	cpu = int((int(cpu0) + int(cpu1) + int(cpu2) + int(cpu3))/4*10)/10
	if cpu > 90:
		urgent=True
	else:
		urgent=False 
	print(getI3Json(inputText = cpuicon, urgent = urgent))
	print(',')		
	print(getI3Json(inputText = str(cpu) + '%', urgent = urgent, separator = True, separator_block_width = 12))

batteryValue = []
def printBattery(lines):
	batteryicon=lines[82]
	battery=lines[83]
	bat=battery[0:3]
	if bat.endswith('% '):
		bat=bat[0:len(bat)-2]
	elif bat.endswith(' ') or bat.endswith('%'):
		bat=bat[0:len(bat)-1]
	if int(bat) > 80:
		color='#00ff00'
	elif int(bat) > 60:
		color='#a8ff00'
	elif int(bat) > 40:
		color='#fff600'
	elif int(bat) > 20:
		color='#ffae00'
	else:
		color='#ff0000'
	text = str(bat) + '%'
	if 'discharging' in battery:
		text = text + ' DIS '
	else:
		text = text + ' CHR '
	if ')' in battery:
		timeh = battery[len(battery)-7:len(battery)-5]
		timem = battery[len(battery)-4:len(battery)-2]
	time = int(timeh)*60 + int(timem)
	if len(batteryValue) >= 20:
		batteryValue.pop(0)
	batteryValue.append(time)
	time = 0
	for val in batteryValue:
		time = time + val;
	time = time / len(batteryValue)
	h = math.floor(time/60)
	m = math.floor((time/60-h)*60)
	strm = str(m)
	if len(strm) == 1:
		strm = "0" + strm
	text = text + "(" + str(h) + ":" + strm + ")"
	print(getI3Json(inputText = batteryicon, textColor = color))
	print(',')		
	print(getI3Json(inputText = text, separator = True, separator_block_width = 12, textColor = color))

def printWIFI(lines):
	wifiip=lines[43]
	if "No Address" in wifiip:
		print(getI3Json(inputText = wifiip, separator = True, separator_block_width = 12, textColor = '#ff0000'))		
	else:
		print(getI3Json(inputText = wifiip, separator = True, separator_block_width = 12, textColor = '#00ff00'))		


def printCaps(lines):
	capslockicon=lines[76]
	capslock=lines[77]
	if "unlocked" not in capslock: 
		print(getI3Json(inputText = capslockicon, urgent = True))
		print(',')
		print(getI3Json(inputText = 'locked', urgent = True, separator = True, separator_block_width = 12))
	else:
		print(getI3Json(inputText = capslockicon, urgent = False, separator = True, separator_block_width = 12))

def printBrightness(lines):
	brigthnessicon=lines[73]
	brigthness=lines[74]
	print(getI3Json(inputText = brigthnessicon))
	print(',')
	print(getI3Json(inputText = brigthness, separator = True, separator_block_width = 12))

def printVolume(lines):
	volumeicon=lines[70]
	volume=lines[71]
	print(getI3Json(inputText = volumeicon))
	print(',')
	print(getI3Json(inputText = volume, separator = True, separator_block_width = 12))

def updateText(conkyFile):
	lines = conkyFile.readlines()

	if len(lines) >= 83:
		print(',[')
		printVolume(lines)
		print(',')
		printBrightness(lines)
		print(',')
		printCaps(lines)
		print(',')
		printWIFI(lines)
		print(',')
		printAvgCpu(lines)
		print(',')
		printCpuTemp(lines)
		print(',')
		printBattery(lines)
		print(',')
		printTime()
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
		sleep(0.5)

'''
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
avgnumber=lines[18]
cpu0text=lines[19]

cpu1text=lines[21]

cpu2text=lines[23]

cpu3text=lines[25]

Memoryswaptext=lines[27]
ramusagetext=lines[28]
ramusage=lines[29]
rampercentage=lines[30]
memoryswaptext=lines[31]
memoryswap=lines[32]
memorypercentage=lines[33]
filesystemtext=lines[34]
filesystemname=lines[35]
filesystemsize=lines[36]
filesystempercentage=lines[37]
readstext=lines[38]
readspersec=lines[39]
writestext=lines[40]
writespersec=lines[41]
networkingtext=lines[42]

downtext=lines[44]
downpersec=lines[45]
uptext=lines[46]
uppersec=lines[47]
downtotaltext=lines[48]
downtotal=lines[49]
uptotaltext=lines[50]
uptotal=lines[51]
empty=lines[52]
topreasurcestext=lines[53]
processestext=lines[54]
numberprocesses=lines[55]
runningtext=lines[56]
runningnumber=lines[57]
cpuusagetext=lines[58]
tableheader=lines[59]
top1cpu=lines[60]
top2cpu=lines[61]
top3cpu=lines[62]
memusagetext=lines[63]
memheader=lines[64]
top1mem=lines[65]
top2mem=lines[66]
top3mem=lines[67]
systemstatstext=lines[68]
volumetext=lines[69]

brightnesstext=lines[72]

capslocktext=lines[75]

batterytext=lines[78]

temperaturetext=lines[81]
'''
