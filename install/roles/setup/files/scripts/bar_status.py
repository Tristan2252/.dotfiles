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

def status_net(bg, fg, delim, stat):
    output = os.popen("conky -i 1").read().rstrip()
    string = "  WAN:    " + output.split(", ")[0] + "    "
    return delim(bg, fg) + "," + make_json(string, bg, fg)

def status_cpu(bg, fg, delim, stat):
    output = os.popen("conky -i 1").read().rstrip()
    string = " CPU:    " + output.split(", ")[1] + "    "
    #return delim(bg, fg) + "," + make_json(string, bg, fg)
    return delim(bg, fg) + "," + make_json(string, bg, fg)

def status_ram(bg, fg, delim, stat):
    output = os.popen("conky -i 1").read().rstrip()
    string = " RAM:  " + output.split(", ")[2] + "    "
    return delim(bg, fg) + "," + make_json(string, bg, fg)

def status_disk(bg, fg, delim, stat):
    output = os.popen("conky -i 1").read().rstrip()
    string = " HDD: " + output.split(", ")[3] + "    "
    return delim(bg, fg) + "," + make_json(string, bg, fg)

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


def status_date(bg, fg, delim):
    day = os.popen("date +'%a'").read().rstrip()
    date_num = os.popen("date +'%m/%d/%Y'").read().rstrip()
    
    string = "     " + day + " " + date_num + "    "
    return delim(bg, fg) + "," + make_json(string, bg, fg)

def status_time(bg, fg, delim):
    time = os.popen("date +'%I:%M:%S'").read().rstrip()
    
    string  = "    " + time + "    "
    return delim(bg, fg) + "," + make_json(string, bg, fg)

def status_bat(bg, fg, delim):
    
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
        return delim(bg, fg) + "," + make_json(string + status_sound(), bg, fg)

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

        return delim("FF0000") + "," + make_json(string + status_sound(), "ff0000", "002b36")

    return delim(bg, fg) + "," + make_json(string + status_sound(), bg, fg)


def main():

    #        BBB  BBBB  AAA  AAAA 
    
    # Background Right side
    a_bg = "24211A"

    # Text Color
    a_fg = "E4E8E9"
    
    # Background Left side
    b_bg = "E4E8E9"

    # Text Color
    b_fg = "24211A"

    # System stats output
    output = os.popen("conky -i 1").read().rstrip()

    # needs to be one single write to stdout because of i3status but 
    sys.stdout.write("[\n" + 
            separator(b_bg) + "," +
            status_date(b_bg, b_fg, dividor) + "," +
            status_time(b_bg, b_fg, dividor) + "," +
            status_net(b_bg, b_fg, dividor, output) + "," +
            status_cpu(a_bg, a_fg, separator, output) + "," +
            status_ram(a_bg, a_fg, dividor, output) + "," +
            status_disk(a_bg, a_fg, dividor, output) + "," +
            separator(b_bg) + "," +
            status_bat(a_bg, a_fg, separator) +
            "],\n")

if __name__ == "__main__":
    main()
    background = "151414FF"
    foreground = "FBA874"
