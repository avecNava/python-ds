# -*- coding: utf-8 -*-
import scrapy
import csv
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.select import Select
# from selenium.webdriver.common.keys import Keys
# from selenium.common.exceptions import NoSuchElementException
# from selenium.webdriver.remote.webelement import WebElement
import datetime
from ..items import NewWebStockPriceItem


# scrapes data from start_urls (newweb.nepalstock.com.np/today-price) 
# and dumps inside output folder as a new file with current date as filename
# this function runs as a cron job every 15 minutes / 30 minutes for the trading hour
# or once every day after trading hour

class NewwebSpider(scrapy.Spider):
    name = 'newweb'
    custom_settings = {
        'USER_AGENT' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36',
        'ITEM_PIPELINES': {
            'stocklive.pipelines.NewWebPipeline': 100
        }
    }
    allowed_domains = ['newweb.nepalstock.com']
    start_urls = ['https://newweb.nepalstock.com/today-price']

    # Initalize the webdriver    
    def __init__(self):
        self.driver = webdriver.Firefox()
        # self.driver = webdriver.Chrome()

    # Parse through each Start URLs
    def start_requests(self):
        for url in self.start_urls:
            yield scrapy.Request(url=url, callback=self.parse)    

    # Parse function: Scrape the webpage and store it
    def parse(self, response):

        today = datetime.date.today()
        current_date_time = datetime.datetime.now()
        item = NewWebStockPriceItem()
        itemList = []

        # https://www.selenium.dev/documentation/en/webdriver/browser_manipulation/
        self.driver.get(response.url)
        self.driver.minimize_window()

        #set transaction date
        # date_element = self.driver.find_element_by_css_selector(".box__filter--wrap  .box__filter--date input")
        # date_text = "%s/%s/%s" %(today.month,today.day,today.year)
        # date_element.clear()
        # # date_element.send_keys(date_text+Keys.ENTER)
        # date_element.send_keys(date_text)

        #set page number to 500
        select_element = self.driver.find_element_by_css_selector(".box__filter--wrap select")
        select_object = Select(select_element)
        select_object.select_by_value('500')

        #find filter button and click
        self.driver.find_element_by_css_selector(".box__filter--wrap button").click()
        # self.driver.save_screenshot('image.png')
        
        # rows = table.find_elements(By.TAGNAME,'tr');
        rows = self.driver.find_elements_by_css_selector("table.table__lg > tbody tr")           #rows is a WebElement

        filename = "output/"+today.strftime("%Y-%m-%d")+"_price.csv"
        with open(filename, 'w+', newline='') as f:
            writer = csv.writer(f)

            for row in rows:
                company = row.find_element_by_css_selector("td:nth-child(2) > a")
                symbol = company.text
                company_name = company.get_attribute('title')
                price_close = row.find_element_by_css_selector("td:nth-child(3)").text.replace(',','')
                price_open = row.find_element_by_css_selector("td:nth-child(4)").text.replace(',','')
                price_high = row.find_element_by_css_selector("td:nth-child(5)").text.replace(',','')
                price_low = row.find_element_by_css_selector("td:nth-child(6)").text.replace(',','')
                total_traded_qty = row.find_element_by_css_selector("td:nth-child(7)").text.replace(',','')
                total_traded_val = row.find_element_by_css_selector("td:nth-child(8)").text.replace(',','')
                total_trades = row.find_element_by_css_selector("td:nth-child(9)").text.replace(',','')
                ltp = row.find_element_by_css_selector("td:nth-child(10)>span:first-child").text.replace(',','')
                prev_day_close_price = row.find_element_by_css_selector("td:nth-child(11)").text.replace(',','')
                avg_traded_price = row.find_element_by_css_selector("td:nth-child(12)").text.replace(',','')
                fifty_two_wks_high = row.find_element_by_css_selector("td:nth-child(13)").text.replace(',','')
                fifty_two_wks_low = row.find_element_by_css_selector("td:nth-child(14)").text.replace(',','')
                market_capitalization = row.find_element_by_css_selector("td:nth-child(15)").text.replace(',','')
                
                #the following two fields yields dash (-) during trading hours, so replace with 0
                price_close = 0 if price_close == '-' else price_close
                market_capitalization = 0 if market_capitalization == '-' else market_capitalization

                # add to item
                item['symbol'] = symbol
                item['company'] = company_name
                item['open_price'] = price_open
                item['high_price'] = price_high
                item['low_price'] = price_low
                item['close_price'] = price_close
                item['last_updated_price'] = ltp
                item['previous_day_close_price'] =prev_day_close_price 
                item['total_traded_qty'] = total_traded_qty
                item['total_traded_value'] = total_traded_val
                item['total_trades'] = total_trades
                item['avg_traded_price'] = avg_traded_price
                item['fifty_two_week_high_price'] = fifty_two_wks_high
                item['fifty_two_week_low_price'] = fifty_two_wks_low
                item['last_updated_time'] = current_date_time
                item['transaction_date'] = today
                item['latest'] = 1
                item['source'] = "newweb"
                item['created_at'] = current_date_time
            
                writer.writerow([   
                    today, symbol, price_close, price_open, price_high, price_low, 
                    total_traded_qty, total_traded_val, total_trades, ltp, prev_day_close_price, 
                    avg_traded_price, fifty_two_wks_high, fifty_two_wks_low, market_capitalization,current_date_time
                ])

                #yield to pipeline for persisting to the db
                yield item

        self.driver.quit()

    #create CSV
    def saveFile(self, items):
        today = datetime.date.today()
        current_date_time = datetime.datetime.now()
        filename = "output/"+today.strftime("%Y-%m-%d")+"_price.csv"
        with open(filename, 'w+', newline='') as f:
            writer = csv.writer(f)
            for item in items:
                # print(item['symbol'])
                writer.writerow([   
                    today, item['symbol'], item['price_close'], item['price_open'], item['price_high'], item['price_low'], 
                    item['total_traded_qty'], item['total_traded_val'], item['total_trades'], item['ltp'], item['prev_day_close_price'], 
                    item['avg_traded_price'], item['fifty_two_wks_high'], item['fifty_two_wks_low'], item['market_capitalization'],current_date_time
                ])
        self.log("Created file %s with %s rows" %(filename, len(items)))
