require 'rubygems'
require 'nokogiri'
require 'open-uri'

while true

def name_key
    @name = []
    doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    doc.xpath('//a[@class="currency-name-container link-secondary"]').each do |i|
    @name << i.text
  end
end



def price_value
    @price = []
    doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    doc.xpath('//a[@class="price"]').each do |e|
    @price << e.text
  end
end

  name_key
  price_value
  hash  = Hash[@name.zip(@price)]

puts hash
sleep(3600)
end
