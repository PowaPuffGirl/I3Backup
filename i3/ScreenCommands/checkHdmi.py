import os 

class Pair:
    def __init__(self, x, y):
        self.x = x
        self.y = y

class Device:
    def __init__(self):
        self.name = ""
        self.resolution = []
    
    def addResolution(self, string):
        resolution=string.split("x")
        value = Pair(resolution[0], resolution[1])
        self.resolution.append(value)

def resetScreen(device):
    os.system("xrandr --output " + device.name + " --scale 1x1")
    os.system("xrandr --output " + device.name + " --scale-from 1920x1080")
    os.system("xrandr --output " + device.name + " --mode 1920x1080")
    os.system("xrandr --output " + device.name + " --auto")
    os.system("xrandr --output " + device.name + " --off")

def setScreenTo(device1, position, device2):
    device1Command = "--output " + device1.name + " --auto "
    device2Command = "--output " + device2.name + " --auto "
    resolutionX=0
    resolutionY=0

    if device1.resolution[0].x > device2.resolution[0].x:
        device2Command = device2Command + "--scale-from " + device1.resolution[0].x + "x" + device1.resolution[0].y + " "
        resolutionX=device1.resolution[0].x
        resolutionY=device1.resolution[0].y
    elif device2.resolution[0].x > device1.resolution[0].x:
        resolutionX=device2.resolution[0].x
        resolutionY=device2.resolution[0].y
        device1Command = device1Command + "--scale-from " + device2.resolution[0].x + "x" + device2.resolution[0].y + " "

    panning = ""
    if position == "Above":
        panning = "--panning " + resolutionX + "x" + resolutionY + "+0+" + resolutionY + " "
        device2Command = device2Command + "--below " + device1.name + " "
        command = "xrandr " + device1Command + device2Command + panning
    elif position == "Below":
        panning = "--panning " + resolutionX + "x" + resolutionY + "+0+" + resolutionY + " "
        device1Command = device1Command + "--below " + device2.name + " "
        command = "xrandr " + device2Command + device1Command + panning
    elif position == "Right":
        panning="--panning " + resolutionX + "x" + resolutionY + "+" + resolutionX +"+0 " 
        device1Command = device1Command + "--right-of " + device2.name + " "
        command = "xrandr " + device2Command + device1Command + panning
    elif position == "Left":
        panning="--panning " + resolutionX + "x" + resolutionY + "+" + resolutionX +"+0 "
        device2Command = device2Command + "--right-of " + device1.name + " "
        command = "xrandr " + device1Command + device2Command + panning
    else:
        return
    print(command)
    for device in devices:
        resetScreen(device)
    os.system("xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 3200x1800 --pos 0x0 --rotate normal --panning 	3200x1800+0+0 --scale 1x1  --output HDMI2 --off --output HDMI1 --off --output DP2 --off")
    os.system("xrandr --output eDP1 --panning 3200x1800+0+0")
    os.system(command)

command = os.popen("xrandr").read()
splitted = command.split('\n')
splitted.pop(0)
devices = []
for line in splitted:
    if not line.startswith(" ") and line != '':
        if "disconnected" not in line:
            device = Device()
            name = line.split(" ")
            device.name = name[0]
            devices.append(device)

counter=-1
for line in splitted:
    if line.startswith(" "):
        value = line.strip().split(" ")
        devices[counter].addResolution(value[0])
    else:
        counter = counter + 1

setScreenTo(devices[0], "Above", devices[1])