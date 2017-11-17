#!/usr/bin/env python3

import os, sys, time

BAT_COLOR="b3b2b2"
SYSTEM_COLOR="b3b2b2"

def make_json(string, bgcolor, fgcolor):
    # this is a mess but cant use json.dump because of unicode chars -__- 
    return """ { "full_text": "<span background='#""" + bgcolor + \
           """' foreground='#""" + fgcolor + """' size='10800' font='FontAwesome 10'> """ + string + \
           """ </span>", "markup": "pango", "separator": false, "separator_block_width": -8}"""

def separator(color):
    return """{ "full_text": "<span foreground='#""" + color + """' size='10800'></span>",""" + \
           """ "markup": "pango", "separator":false, "separator_block_width": 0 }"""

def dividor(bgcolor, fgcolor):
    return """{ "full_text": "<span background='#""" + bgcolor + """' foreground='#""" + fgcolor + \
            """'size='9000'></span>", """ + \
           """ "markup": "pango", "color": "#002b36","separator": false,"separator_block_width": 0}"""

def status_net():
    output = os.popen("conky -i 1").read().rstrip()
    string = "  WAN:    " + output.split(", ")[0] + "    "
    return dividor("262626", "c6c5c5") + "," + make_json(string, "262626", "c6c5c5")

def status_cpu():
    output = os.popen("conky -i 1").read().rstrip()
    string = " CPU:    " + output.split(", ")[1] + "    "
    return separator(SYSTEM_COLOR) + "," + make_json(string, SYSTEM_COLOR, "000000")

def status_ram():
    output = os.popen("conky -i 1").read().rstrip()
    string = " RAM:  " + output.split(", ")[2] + "    "
    return dividor(SYSTEM_COLOR, "000000") + "," + make_json(string, SYSTEM_COLOR, "000000")

def status_disk():
    output = os.popen("conky -i 1").read().rstrip()
    string = " HDD: " + output.split(", ")[3] + "    "
    return dividor(SYSTEM_COLOR, "000000") + "," + make_json(string, SYSTEM_COLOR, "000000")

def status_sound():
    output = os.popen("pactl list sinks | grep Mute | tail -1").read().rstrip()

    output = output.split(": ")[1]
    
    if output == "no":
        string = "   "
    else: 
        string = "   "

    return string


def status_date():
    day = os.popen("date +'%a'").read().rstrip()
    date_num = os.popen("date +'%m/%d/%Y'").read().rstrip()
    
    string = "     " + day + " " + date_num + "    "
    return dividor("262626", "c6c5c5") + "," + make_json(string, "262626", "c6c5c5")

def status_time():
    time = os.popen("date +'%I:%M:%S'").read().rstrip()
    
    string  = "    " + time + "    "
    return dividor("262626", "c6c5c5") + "," + make_json(string, "262626", "c6c5c5")

def status_bat():
    
    output = os.popen("acpi").read().rstrip()
    percent =  output.split(", ")[1]
    state = output.split(" ")[2]
    level = int(percent[0:len(percent) -1])
        
    if state == "Charging,":
        string = "BAT:   {}".format(percent)
        return separator("b3b2b2") + "," + make_json(string + status_sound(), "b3b2b2", "002b36")

    if level <= 100 and level >= 80:
        string = "BAT:   {}".format(percent)
    elif level < 80 and level >= 60:
        string = "BAT:   {}".format(percent)
    elif level < 60 and level >= 40:
        string = "BAT:   {}".format(percent)
    elif level < 40 and level >= 20:
        string = "BAT:   {}".format(percent)
    else: 
        BAT_COLOR = "cb4b16"
        string = "BAT:   {}".format(percent)
        return separator("cb4b16") + "," + make_json(string + status_sound(), "cb4b16", "002b36")

    return separator("b3b2b2") + "," + make_json(string + status_sound(), "b3b2b2", "002b36")




def main():
    
    # needs to be one single write to stdout because of i3status but 
    sys.stdout.write("[\n" + 
            "{},\n".format(status_date()) + 
            "{},\n".format(status_time()) + 
            "{},\n".format(status_net()) + 
            "{},\n".format(separator("002b36")) + 
            "{},\n".format(status_cpu()) + 
            "{},\n".format(status_ram()) + 
            "{},\n".format(status_disk()) + 
            "{},\n".format(separator("002b36")) + 
            "{}\n".format(status_bat()) + 
            "],\n")

if __name__ == "__main__":
    main()
