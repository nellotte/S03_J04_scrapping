require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rest-client'


page = Nokogiri::HTML(URI.open('http://en.wikipedia.org/'))


all_emails_links = page.xpath('/mettre_ici_le_XPath')

/html/body/div[2]/div/div[3]/div/div/div/div[2]/div/h3[2]