#This program reads a list of csv files in the given path, consolidates the contents and creates a new single file
#avecNava
#24 Aug 2020

import os
import csv

csv_files = []
#1. get the list of csv files
path = os.path.join("c:\\","code\\python ds\\data preparation\\merge-csv-files")
path_to_data = os.path.join(path,"data")
# path_to_data = "%s\\data" %(path)

for root, dirs, files in os.walk(path_to_data):
    for file in files:
       if file.endswith(".csv"):
           csv_files.append(root + "\\"+ file)

data = []
#2. loop through the csv files, open  and read them
for csv_file in csv_files:    
    # file = open(csv_file, newline="\n")
    with open(csv_file, newline="\n") as inputfile:
        reader = csv.reader(inputfile)
        header = next(reader)           # skip the header    

        for val in reader:            
            owner = csv_file.split('\\')[-1].split('.')[0]     # parse the filename, strip off the .csv extension to get owner name            
            script = val[1]                                # script name eg, CHCL
            qty_stocks = float(val[2])                     # quantity
            data.append([owner, script, qty_stocks])       # append data in array

# 3. print the contents of the file, write the contents in file
output_path = os.path.join(path,"output.csv")
with open(output_path, 'w', newline='') as outfile:
    writer = csv.writer(outfile)
    writer.writerow(["Owner", "Scripts", "Quantity"])
    for row in data:
        writer.writerow(row)
        print(row)

    

           