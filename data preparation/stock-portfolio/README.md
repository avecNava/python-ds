# Consolidate stock portfolio

26 Aug 2020

## Objective

To read multiple similiar CSV files in a given directory and append the contents into a single file for further analysis.

## Introduction

[Meroshare][2] is an online portal to manage stock traded on [NEPSE][1]. It has a feature to download the profile of logged in users in CSV format. The objective is to read multiple such files and consolidate the information into a single file. In this way, the stock data for various groups (eg, a family with n members) could be combined into a single file and analyzed.

The exported files are named on the basis of owner of the scripts. The output file contains will consolidate the list of stocks along with the owner name.

## Sample CSV file structure

| S.N. | Script | Current Balance | Previous closing price | Value as of Previous closing price| LTP | Value as of LTP |
| ---: | --- | ---: | ---: |---: |---: |---: |
| 1 | ACLBSL | 10 | 719 | 7190 | 714 | 7140 |
| 2 | AKJCL | 20 | 53 | 1060 | 53 | 1060 |
| 3 | BPCL | 24 | 363 | 8712 | 363 | 8712 |
| 4 | HPPL | 10 | 137 | 1370 | 137 | 1370 |
| 5 | JOSHI | 20 | 61 | 1220 | 58 | 11160 |

## Sample output

|Owner | Scripts | Quantity | LTP |
| --- | --- | ---: | ---: |
| User 1 | ACLBSL | 10 | 714 |
| User 1 | AKJCL |  20 | 53 |
| User 2 | BPCL | 24 | 363 |
| User 2 | HPPL | 10 | 137 |
| User 2 | JOSHI | 20 | 58 |

<br>

## 1. Import libraries

```python
import os
import csv
```

## 2. get the list of CSV files in the given path/directory

```python
csv_files = []
#get the list of csv files
path = os.path.join("c:\\","code\\python ds\\data preparation\\stock-portfolio")
path_to_data = os.path.join(path,"data")

for root, dirs, files in os.walk(path_to_data):
    for file in files:
       if file.endswith(".csv"):
           csv_files.append(root + "\\"+ file)
```

## 3. Loop through the CSV file(s), open them and read the contents

```python
data = []
#loop through the csv files, open  and read them
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
```

## 4. write the  the contents of the file and print them

```python
#print the contents of the file, write the contents in file
output_path = os.path.join(path, "output.csv")
with open(output_path, 'w', newline='') as outfile:
    writer = csv.writer(outfile)
    writer.writerow(["Owner", "Scripts", "Quantity","LTP"])
    for row in data:
        writer.writerow(row)
        print(row)

```

## Note on newlines

From [sopython.com][3]

The way Python handles newlines on Windows can result in blank lines appearing between rows when using csv.writer.

In Python 2, opening the file in binary mode disables universal newlines and the data is written properly.

```python
with open('/pythonwork/thefile_subset11.csv', 'wb') as outfile:
    writer = csv.writer(outfile)
```

In Python 3, leave the file in text mode, since you’re writing text, but disable universal newlines.

```python
with open('/pythonwork/thefile_subset11.csv', 'w', newline='') as outfile:
    writer = csv.writer(outfile)
```

[1]: https://nepalstock.com.np
[2]: https://meroshare.com.np
[3]: https://sopython.com/canon/97/writing-csv-adds-blank-lines-between-rows