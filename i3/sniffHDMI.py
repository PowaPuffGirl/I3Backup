import time
import os

def openDisplayselection():
	print("opended")

def buildAvailableList():
	print("built")

screens=os.popen('xrandr | grep -i "\d"').read().split('\n')
availableScreens={}
for screen in screens:
	if len(screen) > 0:
		cutedScreen=screen.split(' ')
		if "disconnected" in cutedScreen[1]:
			availableScreens[cutedScreen[0]] = False
		else:
			availableScreens[cutedScreen[0]] = True

for x, y in availableScreens.items():
	if "eDP1" not in x and y is False:
		usableDisplays=buildAvailableList()
		openDisplayselection()
		break
