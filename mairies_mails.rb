require 'open-uri'
require 'nokogiri'

def get_the_email_of_a_townhal_from_its_webpage
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/vaureal.html"))
    doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

def get_all_the_urls_of_val_doise_townhalls
    array_url = []
	  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	  links = page.css("a[class = lientxt]")

    links.each{|link|
      lien = link['href']
      lien[0] = ''
      array_url << "http://annuaire-des-mairies.com#{lien}"
    }
  return array_url
end

def  get_all_the_emails_of_val_doise_townhalls
 		array_url = get_all_the_urls_of_val_doise_townhalls
   	array_email = []
   	array_url.each do  |url|
     doc = Nokogiri::HTML(open(url))
     mail = 	doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
     array_email << mail
  end

	array_email
end


def get_name
    array = []
      page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
      links = page.css("a[class = lientxt]")
      links.each do |s|
          array << s.text
      end
			array
end

def hash
  hash  = Hash[get_name.zip(get_all_the_emails_of_val_doise_townhalls)]
  hash.each do |name, mail|
   ":nom => #{name} ; :e-mail => #{mail}"
  end
end

puts hash
