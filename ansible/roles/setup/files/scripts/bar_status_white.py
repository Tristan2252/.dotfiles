#!/usr/bin/env python3

import os, sys, time

def make_json(string, bgcolor, fgcolor):
    # this is a mess but cant use json.dump because of unicode chars -__- 
    return """ { "full_text": "<span background='#""" + bgcolor + \
           """' foreground='#""" + fgcolor + """' size='10800' font='FontAwesome 10'> """ + string + \
           """ </span>", "markup": "pango", "separator": false, "separator_block_width": -8}"""

def separator(color, dummy_param=""):
    return """{ "full_text": "<span foreground='#""" + color + """' size='10800'></span>",""" + \
           """ "markup": "pango", "separator":false, "separator_block_width": 0 }"""

def dividor(bgcolor, fgcolor):
    return """{ "full_text": "<span background='#""" + bgcolor + """' foreground='#""" + fgcolor + \
            """'size='9000'></span>", """ + \
           """ "markup": "pango", "color": "#002b36","separator": false,"separator_block_width": 0}"""

def status_net(cpalette, delim, stat):
    output = os.popen("conky -i 1").read().rstrip()
    string = "  WAN:    " + output.split(", ")[0] + "    "
    return delim(cpalette[1], cpalette[2]) + "," + make_json(string, cpalette[1], cpalette[2])

def status_cpu(cpalette, delim, stat):
    output = os.popen("conky -i 1").read().rstrip()
    string = " CPU:    " + output.split(", ")[1] + "    "
    return delim(cpalette[0], cpalette[1]) + "," + make_json(string, cpalette[0], cpalette[1])

def status_ram(cpalette, delim, stat):
    output = os.popen("conky -i 1").read().rstrip()
    string = " RAM:  " + output.split(", ")[2] + "    "
    return delim(cpalette[0], cpalette[1]) + "," + make_json(string, cpalette[0], cpalette[1])

def status_disk(cpalette, delim, stat):
    output = os.popen("conky -i 1").read().rstrip()
    string = " HDD: " + output.split(", ")[3] + "    "
    return delim(cpalette[0], cpalette[1]) + "," + make_json(string, cpalette[0], cpalette[1])

def status_sound():
    try :
        output = os.popen("pactl list sinks | grep Mute | tail -1").read().rstrip()
        output = output.split(": ")[1]
    except IndexError:
        output = "yes"
    
    if output == "no":
        string = "   "
    else: 
        string = "   "

    return string


def status_date(cpalette, delim):
    day = os.popen("date +'%a'").read().rstrip()
    date_num = os.popen("date +'%m/%d/%Y'").read().rstrip()
    
    string = "     " + day + " " + date_num + "    "
    return delim(cpalette[1], cpalette[2]) + "," + make_json(string, cpalette[1], cpalette[2])

def status_time(cpalette, delim):
    time = os.popen("date +'%I:%M:%S'").read().rstrip()
    
    string  = "    " + time + "    "
    return delim(cpalette[1], cpalette[2]) + "," + make_json(string, cpalette[1], cpalette[2])

def status_bat(cpalette, delim):
    
    output = os.popen("acpi").read().rstrip()
    try :
        percent =  output.split(", ")[1]
        state = output.split(" ")[2]
        level = int(percent[0:len(percent) -1])
    except IndexError:
        percent =  ""
        state = ""
        level = 100
        
    if state == "Charging,":
        string = "BAT:   {}".format(percent)
        return delim(cpalette[0], cpalette[1]) + "," + make_json(string + status_sound(), cpalette[0], cpalette[1])

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
        
        ###### figure out how to send notify only once, do not uncomment #####
        #if(percent < 5): 
        #    os.popen("notify-send 'Low Battery' --icon=notification-gpm-battery-empty")

        return delim("d75f00") + "," + make_json(string + status_sound(), "d75f00", "002b36")

    return delim(cpalette[0], cpalette[1]) + "," + make_json(string + status_sound(), cpalette[0], cpalette[1])


def main():

    light_gray = "b3b2b2"
    dark_gray = "262626"
    light_orange = "cc8157"

    color_palette = [light_gray, dark_gray, light_orange]
    output = os.popen("conky -i 1").read().rstrip()

    # needs to be one single write to stdout because of i3status but 
    sys.stdout.write("[\n" + 
            status_date(color_palette, dividor) + "," +
            status_time(color_palette, dividor) + "," +
            status_net(color_palette, dividor, output) + "," +
            status_cpu(color_palette, separator, output) + "," +
            status_ram(color_palette, dividor, output) + "," +
            status_disk(color_palette, dividor, output) + "," +
            separator(color_palette[1]) + "," +
            status_bat(color_palette, separator) + 
            "],\n")

if __name__ == "__main__":
    main()
