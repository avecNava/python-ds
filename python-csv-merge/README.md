# Python Merge CSV files

## This program reads a list of csv files in the given path, consolidates the contents and creates a new single file

24 Aug 2020

## 1. Import required header files

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
