# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy

class StockliveItem(scrapy.Item):    
    symbol = scrapy.Field()
    ltp = scrapy.Field()
    ltv = scrapy.Field()
    change_price = scrapy.Field()
    per_change = scrapy.Field()
    open_price = scrapy.Field()
    high_price = scrapy.Field()
    low_price = scrapy.Field()
    volume = scrapy.Field()
    prev_closing = scrapy.Field()
    trans_date = scrapy.Field()
    source = scrapy.Field()

class TodayPriceItem(scrapy.Item):    
    symbol = scrapy.Field()
    security_name = scrapy.Field()
    security_id = scrapy.Field()

    open_price = scrapy.Field()
    high_price = scrapy.Field()
    low_price = scrapy.Field()
    ltp = scrapy.Field()
    prev_closing = scrapy.Field()

    total_traded_qty = scrapy.Field()
    total_traded_value = scrapy.Field()
    total_trades = scrapy.Field()

    avg_traded_price = scrapy.Field()
    fiftyTwoWeekHigh = scrapy.Field()
    fiftyTwoWeekLow = scrapy.Field()

    total_buy_qty = scrapy.Field()
    total_sell_qty = scrapy.Field()
    last_updated_price = scrapy.Field()
    ltp_datetime = scrapy.Field()
    trans_date = scrapy.Field()

class NewWebStockPriceItem(scrapy.Item):
    symbol = scrapy.Field()
    open_price = scrapy.Field()
    high_price = scrapy.Field()
    low_price = scrapy.Field()
    close_price = scrapy.Field()
    last_updated_price = scrapy.Field()
    previous_day_close_price = scrapy.Field()
    total_traded_qty = scrapy.Field()
    total_traded_value = scrapy.Field()
    total_trades = scrapy.Field()
    avg_traded_price = scrapy.Field()
    fifty_two_week_high_price = scrapy.Field()
    fifty_two_week_low_price = scrapy.Field()
    last_updated_time = scrapy.Field()
    transaction_date = scrapy.Field()
    latest = scrapy.Field()
    source = scrapy.Field()
    created_at = scrapy.Field()