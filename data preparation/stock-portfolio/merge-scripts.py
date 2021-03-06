#This program reads a list of csv files in the given path, consolidates the contents and creates a new single file
#avecNava
#24 Aug 2020

import os
import csv

csv_files = []
#1. get the list of csv files in the given directory
path = os.path.join("c:\\","code\\python ds\\data preparation\\stock-portfolio")
# path = os.path.join("d:\\","OneDrive\\nbogatee\OneDrive - United Nations\\nepse.today\\nava-portfolio")

path_to_data = os.path.join(path,"data")

for root, dirs, files in os.walk(path_to_data):
    for file in files:
       if file.endswith(".csv"):
           csv_files.append(root + "\\"+ file)

data = []
#2. loop through the csv files list, open  and read them
for csv_file in csv_files:
    with open(csv_file, newline="\n") as inputfile:
        reader = csv.reader(inputfile)
        header = next(reader)   #skip the header    

        for val in reader:            
            if val[0].find("Total") == -1 :                     # if the first column doesn't equal to "Total"
                owner = csv_file.split('\\')[-1].split('.')[0]      # get ownername from file (strip off the .csv file extension)
                script = val[1]                                 # second column contains the SCRIPT
                qty_stocks = float(val[2])                      # store qty as float, not string
                ltp = float(val[5])                             # store qty as float, not string
                data.append([owner, script, qty_stocks, ltp])

# 3. print the contents of the file, write the contents in file
output_path = os.path.join(path, "output.csv")
with open(output_path, 'w', newline='') as outfile:
    writer = csv.writer(outfile)
    writer.writerow(["Owner", "Scripts", "Quantity","LTP"])
    for row in data:
        writer.writerow(row)
        print(row)
    
    

           