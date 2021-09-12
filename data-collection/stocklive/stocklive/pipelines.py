# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

# how to set different pipelines for different spiders 
# https://stackoverflow.com/questions/8372703/how-can-i-use-different-pipelines-for-different-spiders-in-a-single-scrapy-proje
# check answer post by Mirage

# import scrapy
import csv
import mysql.connector


class TodayPricePipeline(object):

    def __init__(self):
        pass
    
    def process_item(self, item, spider):
        return item
    
    def close_spider(self, spider):
        pass

class StocklivePipeline(object):

    def __init__(self):
        self.conn = mysql.connector.connect(
            host = "192.168.10.10",
            user = "homestead",
            passwd = "secret",
            database = "nepse2021",
            # charset = "utf-8",
            use_unicode = True
        )        
        self.cursor = self.conn.cursor()
        self.create_tables()  

    #executes for every records in the item repository
    def process_item(self, item, spider):
        if spider.name=='nepsedata':        # separate jobs by spider name
            self.create_record(item)        
            return item
        return item

    def create_record(self, item):    
        self.cursor.execute("""INSERT INTO tblstockdata 
                    (`symbol`, `trans_date`, `ltp`, `ltv`, `change_price`, `per_change`, `open_price`, `high_price`, `low_price`, `volume`, `prev_closing`, `source`)
                    VALUES (%s, %s,%s, %s, %s, %s,%s, %s, %s, %s, %s, %s)""", 
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

class NewWebPipeline(object):

    def __init__(self):
        self.conn = mysql.connector.connect(
            host = "192.168.10.10",
            user = "homestead",
            passwd = "secret",
            # database = "nepse",
            # host = "208.91.199.144",
            # user = "navaneps_admin",
            # passwd = "h[?eQE;HtQy=",
            # database = "navaneps_nepse2021",
            # charset = "utf-8",
            use_unicode = True
        )        
        self.cursor = self.conn.cursor()
        # self.create_tables()  

    #executes for every records in the item repository
    def process_item(self, item, spider):
        if spider.name=='newweb':
            self.create_record(item)        
            return item
        return item

    '''CRUD operations'''
    def create_record(self, item):    
      
        # NOTE : symbol and transaction_date must have UNIQUE key in the schema

        # https://dev.mysql.com/doc/refman/8.0/en/insert-on-duplicate.html
        data = {            
            'symbol' : item['symbol'],
            'company' : item['company'],
            'open_price' : item['open_price'],
            'high_price' : item['high_price'],
            'low_price' : item['low_price'],
            'close_price' : item['close_price'],
            'last_updated_price' : item['last_updated_price'],
            'previous_day_close_price' : item['previous_day_close_price'],
            'total_traded_qty' : item['total_traded_qty'],
            'total_traded_value' : item['total_traded_value'],
            'total_trades' : item['total_trades'],
            'avg_traded_price' : item['avg_traded_price'],
            'fifty_two_week_high_price' : item['fifty_two_week_high_price'],
            'fifty_two_week_low_price' : item['fifty_two_week_low_price'],
            'last_updated_time' : item['last_updated_time'],
            'transaction_date' : item['transaction_date'],
            'latest' : item['latest'],
            'source' : item['source'],
            'created_at' : item['created_at'],
        }

        # 1. insert stock_prices - current rate (the record has no stock_id)
        self.create_or_update_stock_prices(data)
        # 2. reset the latest flag from old records and mark current records as latest
        self.reset_latest_flag(data)
        # 3. create or update companies (if any new)
        self.create_or_update_company(data)
        # 4. update the stock_ids (fetch stock_id from stocks table - id attribute)
        self.update_stock_ids(data)
        '''
            get stock_ids from stocks table and update the stock_prices table for newly inserted records
        '''
        def update_stock_ids(self, data):
            sql = """
                UPDATE stock_prices 
                SET stock_id = (SELECT id FROM stocks WHERE symbol = '{symbol}' LIMIT 1) 
                WHERE latest = 1
            """
            self.cursor.execute(sql.replace('\n','').format_map(data))
        '''
            creates new record or updates existing record based on unique key.
            table `stock_prices` has combined unique key constraint (symbol, transaction_date)
        '''
        def create_or_update_stock_prices(self,data):
            sql = """INSERT INTO stock_prices (`symbol`, `open_price`, `high_price`, `low_price`, `close_price`, `last_updated_price`, 
                `previous_day_close_price`, `total_traded_qty`, `total_traded_value`, `total_trades`, `avg_traded_price`, 
                `fifty_two_week_high_price`,`fifty_two_week_low_price`,`last_updated_time`,`transaction_date`,`latest`,`source`,`created_at`)
                VALUES('{symbol}',{open_price},{high_price},{low_price},{close_price},{last_updated_price}, {previous_day_close_price},
                {total_traded_qty},{total_traded_value},{total_trades},{avg_traded_price},{fifty_two_week_high_price},
                {fifty_two_week_low_price},'{last_updated_time}','{transaction_date}',{latest},'{source}','{created_at}')
                ON DUPLICATE KEY UPDATE
                `high_price`={high_price},`low_price`={low_price},`close_price`={close_price},`last_updated_price`={last_updated_price}, 
                `previous_day_close_price`={previous_day_close_price},`total_traded_qty`={total_traded_qty},`total_traded_value`={total_traded_value},
                `total_trades`={total_trades},`avg_traded_price`={avg_traded_price},`fifty_two_week_high_price`={fifty_two_week_high_price},
                `fifty_two_week_low_price`={fifty_two_week_low_price},`last_updated_time`='{last_updated_time}',`source`='{source}',`updated_at`='{last_updated_time}'
                """
            # print(sql.replace('\n','').format_map(data))
            self.cursor.execute(sql.replace('\n','').format_map(data))
        
        '''reset latest flag to 0 for earlier records'''
        def reset_latest_flag(self, data):
            sql = """
                UPDATE stock_prices SET latest = 0 WHERE symbol = '{symbol}' AND transaction_date < '{transaction_date}'
            """
            self.cursor.execute(sql.replace('\n','').format_map(data))

        '''
            create or update company
            Normally INSERT stops and rolls back when it encounters an error. 
            By using the IGNORE keyword all errors are converted to warnings, which will not stop inserts of additional rows.
            https://mariadb.com/kb/en/insert-ignore/
        '''
        def create_or_update_company(self, data):
            sql = "INSERT IGNORE INTO stocks (`symbol`,`security_name`,`created_at`) VALUES ('{symbol}','{company}','{created_at}')"
            self.cursor.execute(sql.format_map(data))

        '''create table '''
        def create_tables(self):
            self.cursor.execute("""DROP TABLE IF EXISTS stock_prices """)
            self.cursor.execute("""
                CREATE TABLE `stock_prices` (
                `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                `stock_id` bigint(20) unsigned DEFAULT NULL,
                `symbol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                `open_price` float(8,2) DEFAULT NULL,
                `high_price` float(8,2) DEFAULT NULL,
                `low_price` float(8,2) DEFAULT NULL,
                `close_price` float(8,2) DEFAULT NULL,
                `last_updated_price` float(8,2) DEFAULT NULL,
                `previous_day_close_price` float(8,2) NOT NULL,
                `total_traded_qty` mediumint(8) unsigned DEFAULT NULL,
                `total_traded_value` int(10) unsigned DEFAULT NULL,
                `total_trades` mediumint(8) unsigned DEFAULT NULL,
                `avg_traded_price` double(8,2) DEFAULT NULL,
                `fifty_two_week_high_price` double(8,2) DEFAULT NULL,
                `fifty_two_week_low_price` double(8,2) DEFAULT NULL,
                `last_updated_time` datetime DEFAULT NULL,
                `transaction_date` date NOT NULL,
                `latest` tinyint(1) NOT NULL DEFAULT 0,
                `source` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'nepalstock',
                `created_at` timestamp NULL DEFAULT NULL,
                `updated_at` timestamp NULL DEFAULT NULL,
                PRIMARY KEY (`id`),
                KEY `stock_prices_symbol_IDX` (`symbol`) USING BTREE
                ) ENGINE=InnoDB AUTO_INCREMENT=180958 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
        """)

        def close_spider(self, spider):
            self.conn.commit()
            self.cursor.close()
            self.conn.close()


class CSVPipeline(object):
    pass