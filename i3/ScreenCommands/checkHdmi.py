import os 
import sys

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

def callCommand(command):
    for device in devices:
        resetScreen(device)
    os.system(command)

def resetScreen(device):
    os.system("xrandr --output " + device.name + " --scale 1x1")
    os.system("xrandr --output " + device.name + " --scale-from " + device.resolution[0].x + "x" + device.resolution[0].y + " ")
    os.system("xrandr --output " + device.name + " --mode " + device.resolution[0].x + "x" + device.resolution[0].y + " ")
    os.system("xrandr --output " + device.name + " --auto")
    os.system("xrandr --output " + device.name + " --off")

def resetAllDevices():
    for device in devices:
        resetScreen(device)    

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
    else:
        resolutionX=device1.resolution[0].x
        resolutionY=device1.resolution[0].y

    panning = ""
    if position == "Above":
        panning = "--panning " + str(resolutionX) + "x" + str(resolutionY) + "+0+" + str(resolutionY) + " "
        device2Command = device2Command + "--below " + device1.name + " "
        command = "xrandr " + device1Command + device2Command + panning
    elif position == "Below":
        panning = "--panning " + str(resolutionX) + "x" + str(resolutionY) + "+0+" + str(resolutionY) + " "
        device1Command = device1Command + "--below " + device2.name + " "
        command = "xrandr " + device2Command + device1Command + panning
    elif position == "Right":
        panning="--panning " + str(resolutionX) + "x" + str(resolutionY) + "+" + str(resolutionX) +"+0 " 
        device1Command = device1Command + "--right-of " + device2.name + " "
        command = "xrandr " + device2Command + device1Command + panning
    elif position == "Left":
        panning="--panning " + str(resolutionX) + "x" + str(resolutionY) + "+" + str(resolutionX) +"+0 "
        device2Command = device2Command + "--right-of " + device1.name + " "
        command = "xrandr " + device1Command + device2Command + panning
    elif position == "Duplicate":
        panning = "--panning " + str(resolutionX) + "x" + str(resolutionY) + "+0+0 "
        device1Command = device1Command + "--primary "
        device2Command = device2Command + "--same-as " + device1.name + " "
        command = "xrandr " + device1Command + device2Command + panning
    else:
        return
    return command
    
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

if len(sys.argv) < 4:
    if len(sys.argv) < 2:
        print("Please add some system arguments!")
        print("\t1: Displayname that should stay the same")
        print("\t2: The Position of the Second Display relative to the first -> Above|Below|Right|Left|Duplicate")
        print("\t3: Displayname that shoulde be repositioned")
        print("Or you can add:")
        print("\t1: Displayname that should be used only")
    else:
        device1 = str(sys.argv[1])
        device1found=False
        for device in devices:
            if device.name == device1:
                device1found=True
                device1=device
        if device1found:
            resetAllDevices()
            os.system("xrandr --output " +  str(device1.name) + " --auto --primary --panning " + device1.resolution[0].x + "x" + device1.resolution[0].y + "+0+0 ")
                
else:
    device1 = str(sys.argv[1])
    position = str(sys.argv[2])
    device2 = str(sys.argv[3])
    device1found=False
    device2found=False
    for device in devices:
        if device.name == device1:
            device1found=True
            device1=device
        if device.name == device2:
            device2found=True
            device2=device

    if device1found and device2found:
        command = setScreenTo(device1, position, device2)
        if command == None:
            print("Not a matching display Position! -> Above|Below|Right|Left|Duplicate")
        else:
            resetAllDevices()
            print(command)
            callCommand(command)
    else:
        print("One or two devices could not be found!")
        print("please check the xrandr command for device names!")
        print("or replug the display cable!")