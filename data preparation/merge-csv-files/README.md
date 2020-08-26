# Python Merge CSV files

## This program reads a list of csv files in the given path, consolidates the contents and creates a new single file

24 Aug 2020

## Objective

To read multiple similiar CSV files in a given directory and append the contents into a single file.

## Introduction

The CSV files are exported from *My Shares* on [meroshare][2]. The file contains stock details for the given user.

The exported files are named on the basis of owner of the scripts. The output file contains a new column called *owner* which will be the file name.

## Sample CSV file structure

| S.N. | Script | Current Balance | Pledge Balance | Locking Balance| Freeze Balance | Free Balance | Demat Pending | Remarks |
| ---: | --- | ---: | ---: |---: |---: |---: |---: |--- |
| 1 | JOSHI | 10 | 0 | 0 | 0 | 10 | 0 | |
| 2 | NMB | 15 | 0 | 0 | 0 | 10 | 0 | |
| 3 | RRHP | 10 | 0 | 0 | 0 | 10 | 0 | |
| 4 | UPPER | 10 | 0 | 0 | 0 | 10 | 0 | |
| 5 | NLICL | 40 | 0 | 0 | 0 | 10 | 0 | |

## Sample output

|Owner | Scripts | Quantity |
| --- | --- | ---: |
| User 1 | JOSHI | 10 |
| User 1 | NMB |  15 |
| User 2 | RRHP | 10 |
| User 2 | UPPER | 40 |

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
path = os.path.join("c:\\","data\\csv")
for root, dirs, files in os.walk(path):
    for file in files:
       if file.endswith(".csv"):
           csv_files.append(root + "\\"+ file)
```

## 3. Loop through the CSV file(s), open them and read the contents

```python
data = []
#loop through the csv files, open  and read them
for path in csv_files:
    # file = open(path, newline="\n")
    with open(path, newline="\n") as inputfile:
        reader = csv.reader(inputfile)
        header = next(reader)   #skip the header

        for row in reader:
            owner = path.split('\\')[-1].split('.')[0]
            script = row[1]
            qty_stocks = float(row[2])

            data.append([owner, script, qty_stocks])
```

## 4. write the  the contents of the file and print them

```python
#print the contents of the file, write the contents in file
path = "c:\\data\\output.csv"
with open(path, 'w', newline='') as outfile:
    writer = csv.writer(outfile)
    writer.writerow(["Owner", "Scripts", "Quantity"])
    for row in data:
        writer.writerow(row)
        print(row)

```

## Note on newlines

From [sopython.com][1]

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

[1]: https://sopython.com/canon/97/writing-csv-adds-blank-lines-between-rows
[2]: https://meroshare.com.np