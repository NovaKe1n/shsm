#!/usr/bin/python

#title|coronaNews
#version|0.1
#author|0ero1ne
#info|retrive information from corona-stats.online

from datetime import datetime
import requests
import json

dirfile = '/home/null/Documents/corona_update/news'
url = 'https://corona-stats.online/updates?format=json'

r = requests.get(url)
cont = json.loads(r.content)

with open(dirfile,'w',encoding = 'utf-8') as f:
    for x in cont:
        time = int(str(x).split("'timestamp':")[1][:-1])
        ctime = datetime.fromtimestamp(time).strftime('%I:%M%p - %A %d/%m/%Y').replace("PM","p.m.").replace("AM","a.m.")
        url = str(str(x).split("'url':")[1]).split(",")[0][2:-1]
    
        #Description
        #print("[",ctime,"]")
        #print(str(x).split("'url':")[0][17:-3])

        #url
        #print("[URL]")
        #print("("+url+")")
    
        f.write("\n["+ctime+"]\n")
        f.write("-"*33)
        f.write("\n"+str(x).split("'url':")[0][17:-3])
        f.write(("\n("+url+")\n\n"))
