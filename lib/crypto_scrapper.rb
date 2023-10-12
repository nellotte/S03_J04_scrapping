require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rest-client'

puts "Scrapping de la page coinmarketcap.com"
puts 'Je récupère les 10 premières devises de la liste'

def scrapping
  page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))
 
  return page
end

def crypto_scrapping(page)
  crypto_table = []
  (1..20).each do |index|
    xpath = "/html/body/div[1]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[#{index}]/td[3]/div"
    crypto_code = page.xpath(xpath).text
    crypto_table << crypto_code  #remplir le tableau avec les codes trouvés
  end
puts "Toutes les codes de crypto ont été récupérés avec succès"
return crypto_table
end

def prices_scrapping(page)
  puts 'Je récupère les 10 premières devises de la liste'
  prices_table = []
  (1..20).each do |index|
    xpath = "/html/body/div[1]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[#{index}]/td[5]/div/a/span"
    crypto_price = page.xpath(xpath).text
    prices_table << crypto_price
  end
puts "Toutes les prix de crypto ont été récupérés avec succès"
return prices_table
end

def create_final_table(crypto_table, prices_table)
  crypto_and_prices_table = {}
  crypto_table.each_with_index do |crypto, price|
    crypto_and_prices_table[crypto] = prices_table[price]
  end
  puts "Voici le liste des cryptos et leur valeur :"
  crypto_and_prices_table.each{|crypto,price| puts "#{crypto} : #{price}"}
return crypto_and_prices_table
end

  # parcours l'ensemble du hashes et à chaque row il va faire un puts de la key et de la value ==> permet une présentation plus soignée du tableau

#appel des différentes methodes
crypto_table = crypto_scrapping(scrapping)
prices_table = prices_scrapping(scrapping)
create_final_table(crypto_table, prices_table)

