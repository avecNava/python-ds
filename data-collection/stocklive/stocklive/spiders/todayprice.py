# -*- coding: utf-8 -*-
import scrapy
import json
from ..items import TodayPriceItem

class NepsedataSpider(scrapy.Spider):
    name = 'todayprice'
    custom_settings = {
        'USER_AGENT' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36',
        'ITEM_PIPELINES': {
            'stocklive.pipelines.TodayPricePipeline': 100
        }
    }

    # start_urls = [  
        # 'file:///C:\\code\\python ds\\data collection\\stocklive\\nepse.html'
        # ]

    start_urls = [  
        'https://newweb.nepalstock.com/api/nots/nepse-data/today-price?&size=500&businessDate=2020-11-03'
        ]

    def parse(self, response):
        
        items = TodayPriceItem()
        json_response = json.loads(response.text)
        listings = json_response['content']
        
        for listing in listings:
            
            symbol = listing["symbol"]
            security_name = listing["securityName"]
            security_id = listing["securityId"]

            open_price = listing["openPrice"]
            high_price = listing["highPrice"]
            low_price = listing["lowPrice"]
            ltp = listing["closePrice"]            
            prev_closing = listing["previousDayClosePrice"]

            total_traded_qty = listing["totalTradedQuantity"]
            total_traded_value = listing["totalTradedValue"]         
            total_trades = listing["totalTrades"]         

            avg_traded_price = listing["averageTradedPrice"]
            fiftyTwoWeekHigh = listing["fiftyTwoWeekHigh"]
            fiftyTwoWeekLow = listing["fiftyTwoWeekLow"]

            total_buy_qty = listing["totalBuyQuantity"]
            total_sell_qty = listing["totalSellQuantity"]            
            last_updated_price = listing["lastUpdatedPrice"]
            ltp_datetime = listing["lastUpdatedTime"]      
            trans_date = listing["businessDate"]

            items['symbol'] = symbol.strip()
            items['security_name'] = security_name.strip()
            items['security_id'] = security_id
            items['open_price'] = open_price
            items['high_price'] = high_price
            items['low_price'] = low_price
            items['ltp'] = ltp
            items['prev_closing'] = prev_closing
            items['total_traded_qty'] = total_traded_qty
            items['total_traded_value'] = total_traded_value
            items['total_trades'] = total_trades
            items['avg_traded_price'] = avg_traded_price
            items['fiftyTwoWeekHigh'] = fiftyTwoWeekHigh
            items['fiftyTwoWeekLow'] = fiftyTwoWeekLow
            items['total_buy_qty'] = total_buy_qty
            items['total_sell_qty'] = total_sell_qty
            items['last_updated_price'] = last_updated_price
            items['ltp_datetime'] = ltp_datetime            
            items['trans_date'] = trans_date
            
            # print(items)
            
            yield items
        
        
