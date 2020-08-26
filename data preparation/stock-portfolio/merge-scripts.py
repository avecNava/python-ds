#This program reads a list of csv files in the given path, consolidates the contents and creates a new single file
#avecNava
#24 Aug 2020

import os
import csv

csv_files = []
#1. get the list of csv files
path = os.path.join("c:\\","code\\nepse\\csv")
directory = path.split('\\')[-1]

for root, dirs, files in os.walk(path):
    for file in files:
       if file.endswith(".csv"):
           csv_files.append(root + "\\"+ file)

data = []
#2. loop through the csv files, open  and read them
for path in csv_files:    
    # file = open(path, newline="\n")
    with open(path, newline="\n") as inputfile:
        reader = csv.reader(inputfile)
        header = next(reader)   #skip the header    

        for val in reader:
            
            if val[0].find("Total") == -1 :                     # if the first column doesn't equal to "Total"
                owner = path.split('\\')[-1].split('.')[0]      # get ownername from file (strip off the .csv file extension)
                script = val[1]                                 # second column contains the SCRIPT
                qty_stocks = float(val[2])                      # store qty as float, not string
                ltp = float(val[5])                             # store qty as float, not string

                data.append([owner, script, qty_stocks, ltp])

# 3. print the contents of the file, write the contents in file
path = "c:\\code\\nepse\\output-%s.csv" %(directory)
with open(path, 'w', newline='') as outfile:
    writer = csv.writer(outfile)
    writer.writerow(["Owner", "Scripts", "Quantity","LTP"])
    for row in data:
        writer.writerow(row)
        print(row)
    
    

           