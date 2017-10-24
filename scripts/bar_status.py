#!/usr/bin/env python3

import os, sys, time

BAT_COLOR="b3b2b2"

def make_json(string, bgcolor, fgcolor):
    # this is a mess but cant use json.dump because of unicode chars -__- 
    return """ { "full_text": "<span background='#""" + bgcolor + \
           """' foreground='#""" + fgcolor + """' size='10800' font='FontAwesome 10'> """ + string + \
           """ </span>", "markup": "pango", "separator": false, "separator_block_width": -8}"""

#def separator(color):
#    return """{ "full_text": "<span foreground='#""" + color + """' size='11000' font='FontAwesome 10'></span>",""" + \
#           """ "markup": "pango", "separator":false, "separator_block_width": -6 }"""

def separator(color):
    return """{ "full_text": "<span foreground='#""" + color + """' size='10800'></span>",""" + \
           """ "markup": "pango", "separator":false, "separator_block_width": 0 }"""

def dividor(color):
    return """{ "full_text": "<span background='#""" + color + """' size='9000'></span>", """ + \
           """ "markup": "pango", "color": "#002b36","separator": false,"separator_block_width": 0}"""

def status_net():
    output = os.popen("conky -i 1").read().rstrip()
    string = " WAN:    " + output.split(", ")[0] + "    "
    return make_json(string, "002b36", "859900")

def status_cpu():
    output = os.popen("conky -i 1").read().rstrip()
    string = "CPU:    " + output.split(", ")[1] + "    "
    return make_json(string, "b58900", "002b36")

def status_ram():
    output = os.popen("conky -i 1").read().rstrip()
    string = "RAM:  " + output.split(", ")[2] + "    "
    return make_json(string, "b58900", "002b36")

def status_disk():
    output = os.popen("conky -i 1").read().rstrip()
    string = "HDD: " + output.split(", ")[3] + "    "
    return make_json(string, "b58900", "002b36")

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
    
    string = "   " + day + " " + date_num + "   "
    return make_json(string, "859900", "002b36")

def status_time():
    time = os.popen("date +'%I:%M:%S'").read().rstrip()
    
    string  = "  " + time + "   "
    return make_json(string, "859900", "002b36")

def status_bat():
    
    output = os.popen("acpi").read().rstrip()
    percent =  output.split(", ")[1]
    state = output.split(" ")[2]
    level = int(percent[0:len(percent) -1])
        
    if state == "Charging,":
        string = "BAT:   {}".format(percent)
        return make_json(string + status_sound(), "b3b2b2", "002b36")

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
        return make_json(string + status_sound(), "cb4b16", "002b36")

    return make_json(string + status_sound(), "b3b2b2", "002b36")




def main():
    
    # needs to be one single write to stdout because of i3status but 
    sys.stdout.write("[\n" + 
            "{},\n".format(separator("b58900")) + 
            "{},\n".format(status_cpu()) + 
            "{},\n".format(dividor("b58900")) + 
            "{},\n".format(status_ram()) + 
            "{},\n".format(dividor("b58900")) + 
            "{},\n".format(status_disk()) + 
            "{},\n".format(separator("002b36")) + 
            "{},\n".format(status_net()) + 
            "{},\n".format(separator("859900")) + 
            "{},\n".format(status_date()) + 
            "{},\n".format(dividor("859900")) + 
            "{},\n".format(status_time()) + 
            "{},\n".format(separator(BAT_COLOR)) + 
            "{}\n".format(status_bat()) + 
            "],\n")

if __name__ == "__main__":
    main()
