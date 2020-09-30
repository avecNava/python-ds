# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

import csv
import mysql.connector
# from scrapy import signals
# from scrapy.exporters import CsvItemExporter

class StocklivePipeline(object):

    def __init__(self):

        self.conn = mysql.connector.connect(
                host = "192.168.10.10",
                user = "homestead",
                passwd = "secret",
                database = "test",
                # charset = "utf-8",
                use_unicode = True
            )
        
        self.cursor = self.conn.cursor()
        # self.create_tables()  

    #executes for every records in the item repository
    def process_item(self, item, spider):
        print('========================================================================================================')
        self.create_record(item)
        
        return item

    def create_record(self, item):    
        self.cursor.execute("""INSERT INTO tblstockdata 
                        (`symbol`, `trans_date`, `ltp`, `ltv`, `change_price`, `per_change`, `open_price`, `high_price`, `low_price`, `volume`, `prev_closing`, `source`)
                        VALUES (%s, %s, %s, %s, %s, %s,%s, %s, %s, %s, %s, %s)""", 
                        (   item['symbol'],
                            item['trans_date'],
                            item['ltp'],
                            item['ltv'],
                            item['change_price'],
                            item['per_change'],
                            item['open_price'],
                            item['high_price'],
                            item['low_price'],
                            item['volume'],
                            item['prev_closing'],
                            item['source']
                        )
                    )
        self.conn.commit() 

    #Read the documentation about making tables
    #https://dev.mysql.com/doc/connector-python/en/connector-python-example-ddl.html

    def create_tables(self):
        self.cursor.execute("""DROP TABLE IF EXISTS tblstockdata """)
        self.cursor.execute("""
            CREATE TABLE tblstockdata (
                symbol VARCHAR(12) NOT NULL,
                trans_date datetime NOT NULL,
                ltp DECIMAL(7,2) NOT NULL,
                ltv INT NOT NULL,
                change_price DECIMAL(7,2) NOT NULL,
                per_change DECIMAL(5,2) NOT NULL,
                open_price DECIMAL(7,2) NOT NULL,
                high_price DECIMAL(7,2) NOT NULL,
                low_price DECIMAL(7,2) NOT NULL,
                volume INT NOT NULL,
                prev_closing DECIMAL(7,2) NOT NULL,
                source VARCHAR(10) DEFAULT 'stocklive'
            )
        """)

    def close_spider(self, spider):
        self.cursor.close()
        self.conn.close()

#     def process_item(self, item, spider):
#         return item


# class CSVPipeline(object):

#     def __init__(self):
#         self.files = {}

#     @classmethod
#     def from_crawler(cls, crawler):
#         pipeline = cls()
#         crawler.signals.connect(pipeline.spider_opened, signals.spider_opened)
#         crawler.signals.connect(pipeline.spider_closed, signals.spider_closed)
#         return pipeline

#     def spider_opened(self, spider):
#         file = open('%s_items.csv' % spider.name, 'w+b')
#         self.files[spider] = file
#         self.exporter = CsvItemExporter(file)
#         self.exporter.fields_to_export = ["plotid","plotprice","plotname","name","address"]
#         self.exporter.start_exporting()

#     def spider_closed(self, spider):
#         self.exporter.finish_exporting()
#         file = self.files.pop(spider)
#         file.close()

#         #given I am using Windows i need to elimate the blank lines in the csv file
#         print("Starting csv blank line cleaning")
#         with open('%s_items.csv' % spider.name, 'r') as f:
#             reader = csv.reader(f)
#             original_list = list(reader)
#             cleaned_list = list(filter(None,original_list))

#         with open('%s_items_cleaned.csv' % spider.name, 'w', newline='') as output_file:
#             wr = csv.writer(output_file, dialect='excel')
#             for data in cleaned_list:
#                 wr.writerow(data)

#     def process_item(self, item, spider):
#         self.exporter.export_item(item)
#         return item

    # class FixCsvItemExporter(CsvItemExporter):

    #     def __init__(self, *args, **kwargs):
    #         newline = settings.get('CSV_NEWLINE', '')
    #         kwargs['newline'] = newline
    #         super(FixCsvItemExporter, self).__init__(*args, **kwargs)