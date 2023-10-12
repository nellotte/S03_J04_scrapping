require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rest-client'


def scrapping(url)
  page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))
  puts "Scrapping : OK"
  return page
end

def crypto_scrapping(page)
  puts "Je récupère les 10 premières devises de la liste"
  crypto_table = []

  (1..10).each do |index|
    xpath = "/html/body/div[1]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[#{index}]/td[3]/div"
    crypto_code = page.xpath(xpath).text

    crypto_table << crypto_code  #remplir le tableau avec les codes trouvés

    puts "Crypto scrappée : #{crypto_code}"
  end
#à la fin des 10 codes récupérés, j'annonce que c'est fini
puts "Toutes les codes de crypto ont été récuppérés avec succès"
return crypto_table
puts crypto_table #ca c'est pour que je puisse vérifier cette étape
end

scrapping("https://coinmarketcap.com/all/views/all/")
crypto_scrapping("https://coinmarketcap.com/all/views/all/")