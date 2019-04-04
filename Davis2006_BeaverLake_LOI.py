# This script reads a csv file with digitized data and extrapolates ad interpolates ages (if depth is used)

import time
sTime = time.clock()
import csv
csvfile = r"C:\NRE5695\CSV_XLS\BeaverLake_LOI.csv"

Age = []
Depth = []
LOI_Depth = []

with open(csvfile, 'r') as csv_file: 
    csv_reader = csv.reader(csv_file)
    for i in range(1):
        next(csv_reader)
    for line in csv_reader:
        LOI_Depth.append(float(line[3]))
        Age.append(float(line[0]))
        Depth.append(float(line[1]))
csv_file.close()

## Calculates age for TP
LOI_Age = []
for cm in LOI_Depth:
    if cm<min(Depth):
        Yr = Age[80]+(cm-Depth[80])/(Depth[80]-Depth[79])*(Age[80]-Age[79])
        LOI_Age.append(Yr)
        print Yr
    elif cm>max(Depth): # Linear Extrapolation
        Yr = Age[0]+(cm-Depth[0])/(Depth[1]-Depth[0])*(Age[1]-Age[0])
        LOI_Age.append(Yr)
        print Yr
    else:
        for x in range(81):        
            if Depth[x]> cm>Depth[x-1]: #Linear Interpolation
                Yr = Age[x-1]+(cm-Depth[x-1])*(Age[x]-Age[x-1])/(Depth[x]-Depth[x-1])
                print Yr
                LOI_Age.append(Yr)
                break
print len(LOI_Age)

eTime = time.clock()
elapsedT = eTime-sTime
print ''
print 'script complete'
print "Run-time is %s seconds" % (elapsedT)
