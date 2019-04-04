# This script reads a csv file with digitized data and extrapolates ad interpolates ages (if depth is used)

import time
sTime = time.clock()
import csv
csvfile = r"C:\NRE5695\CSV_XLS\Davis2006_Beaverlake.csv" 

Age = []
Depth = []
TP_Depth = []
pH_Depth = []

with open(csvfile, 'r') as csv_file: 
    csv_reader = csv.reader(csv_file)
    for i in range(1):
        next(csv_reader)
    for line in csv_reader:
        Age.append(float(line[0]))
        Depth.append(float(line[1]))
        if len(TP_Depth)==17:
            continue
        else:
            TP_Depth.append(float(line[3]))
            pH_Depth.append(float(line[5]))
csv_file.close()

print len(pH_Depth)
print TP_Depth
print len(Depth)
print Depth
print len(Age)

## Calculates age for TP
TP_Age = []
for cm in TP_Depth:
    if cm<min(Depth):
        Yr = Age[80]+(cm-Depth[80])/(Depth[80]-Depth[79])*(Age[80]-Age[79])
        TP_Age.append(Yr)
        print Yr
    elif cm>max(Depth): # Linear Extrapolation
        Yr = Age[0]-(cm-Depth[0])/(Depth[1]-Depth[0])*(Age[1]-Age[0])
        TP_Age.append(Yr)
        print Yr
    else:
        for x in range(81):        
            if Depth[x]> cm>Depth[x-1]: #Linear Interpolation
                Yr = Age[x-1]+(cm-Depth[x-1])*(Age[x]-Age[x-1])/(Depth[x]-Depth[x-1])
                print Yr
                TP_Age.append(Yr)
                break
print len(TP_Age)

## Calculates age for pH
pH_Age = []
for cm in pH_Depth:
    if cm<min(Depth):
        Yr = Age[80]+(cm-Depth[80])/(Depth[80]-Depth[79])*(Age[80]-Age[79])
        pH_Age.append(Yr)
        print Yr
    elif cm>max(Depth): # Linear Extrapolation
        Yr = Age[0]-(cm-Depth[0])/(Depth[1]-Depth[0])*(Age[1]-Age[0])
        pH_Age.append(Yr)
        print Yr
    else:
        for x in range(81):        
            if Depth[x]> cm>Depth[x-1]: #Linear Interpolation
                Yr = Age[x-1]+(cm-Depth[x-1])*(Age[x]-Age[x-1])/(Depth[x]-Depth[x-1])
                print Yr
                pH_Age.append(Yr)
                break
print len(pH_Age)


eTime = time.clock()
elapsedT = eTime-sTime
print ''
print 'script complete'
print "Run-time is %s seconds" % (elapsedT)
