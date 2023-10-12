require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rest-client'

def get_townhall_url
  #scrapper les urls des mairies
  table_95_url = [] # Crée une liste vide pour stocker les url des villes
  scrapped_page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
  xpath = '//a[@class="lientxt"]'
  townhall_elements = scrapped_page.xpath(xpath)
 
  #boucle pour parcourir la page et ajouter l'url des villes
  townhall_elements.each do |townhall_element|
    suffixe_url = townhall_element['href']

    #construction de l'url complet (partie fixe + suffixe par ville)
    townhall_url = "http://annuaire-des-mairies.com" + suffixe_url
    table_95_url << townhall_url
  end
  puts table_95_url
  return table_95_url
end

def get_townhall_emailadress(table_95_url) #scrapper pour chaque page de ville l'email... Or Il te faut fournir à chaque fois l'url personnalisé de la ville. Tel que "http://annuaire-des-mairies.com#{city_url}"
table_95_emailadress = []
#boucle pour passer sur chaque élément de la liste 95_url
table_95_url.each do |city_url|
  scrapped_city_page = Nokogiri::HTML(URI.open(city_url))
  xpath = "/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]"
  city_email = scrapped_city_page.xpath(xpath).text
  table_95_emailadress << city_email
end
puts table_95_emailadress
return table_95_emailadress
end

def get_townhall_name
 #scrapper les nom des bleds
 table_95_names = [] # Crée une liste vide pour stocker les noms des villes
 scrapped_page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
 xpath = '//a[@class="lientxt"]'
 townhall_elements = scrapped_page.xpath(xpath)

 #boucle pour parcourir la page et ajouter l'url des villes
 townhall_elements.each do |townhall_element|
   townhall_name = townhall_element.text
   table_95_names << townhall_name
 end
 puts table_95_names
 return table_95_names
end

#appel des différentes def
townhall_urls = get_townhall_url
townhall_names = get_townhall_name
townhall_emails = get_townhall_emailadress