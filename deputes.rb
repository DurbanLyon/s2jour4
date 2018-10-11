require 'rubygems'
require 'nokogiri'
require 'open-uri'

def lastname_firstname
    @name = []
    doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
    doc.xpath('/html/body/div/div/div/section/div/article/div/div/div/div/ul/li/a').each do |i|
    @name.push({ Prénom: i.text.split(' ')[1], Nom: i.text.split(' ')[2]})
  end
  puts @name
end


def email_value
    @email = []
    doc = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=576"))
    doc.css('a[@href ^="mailto:"]').each do |e|
    @email << e.text
  end
  @email.keep_if { |w| w =~ /assemblee-nationale.fr$/ }
  @email.delete_if {|w| w =~ /secretariat-blanchet/}
  @email.delete_if {|w| w =~ /bureau-m-orphelin/}

  puts @email
end

lastname_firstname
email_value
