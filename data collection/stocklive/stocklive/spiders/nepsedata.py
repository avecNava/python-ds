# -*- coding: utf-8 -*-
import scrapy
from ..items import StockliveItem

class NepsedataSpider(scrapy.Spider):
    name = 'nepsedata'
    # allowed_domains = ['stocklive.com.np']
    # start_urls = [  
    #     'file:///C:\\code\\python ds\\data collection\\stocklive\\nepse.html'
    #     ]
    start_urls = [  
        'http://nepalstock.com.np/stocklive'
        ]
                                    
    def parse(self, response):
        self.log('\n\nA response from %s just arrived!\n' % response.url)

        today_date = response.xpath('//*[@id="market-watch"]/div[1]/text()').extract()[0]
        self.log(today_date.replace('As of ',''))

        items = StockliveItem()
        rows = response.xpath("//*[@id='home-contents']/div[3]/table/tbody/tr")
        
        # if ".org" in response.url:
        #     from scrapy.shell import inspect_response
        #     inspect_response(response, self)
        
        for row in rows:
            symbol = row.xpath('td[2]/text()').extract()[0]
            # symbol = row.css('td:nth-child(2)::text').extract()[0]
            ltp = row.xpath('td[3]/text()').extract()[0]
            ltv = row.xpath('td[4]/text()').extract()[0]
            change_price = row.xpath('td[5]/text()').extract()[0]
            per_change = row.xpath('td[6]/text()').extract()[0]
            open_price = row.xpath('td[7]/text()').extract()[0]
            high_price = row.xpath('td[8]/text()').extract()[0]
            low_price = row.xpath('td[9]/text()').extract()[0]
            volume = row.xpath('td[10]/text()').extract()[0]
            prev_closing = row.xpath('td[11]/text()').extract()[0]            
            
            items['symbol'] = symbol.strip()
            items['ltp'] = ltp.replace(',','')
            items['change_price'] = change_price.replace(',','')
            items['per_change'] = per_change.replace(',','')
            items['open_price'] = open_price.replace(',','')
            items['high_price'] = high_price.replace(',','')
            items['low_price'] = low_price.replace(',','')
            items['prev_closing'] = prev_closing.replace(',','')
            items['ltv'] = ltv.replace(',','')
            items['volume'] = volume.replace(',','')
            items['trans_date'] = today_date.replace('As of ','')
            items['source'] = 'stocklive'
            
            yield items
        
        
