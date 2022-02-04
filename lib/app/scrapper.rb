
class Scrapper

  def initialize
    @list = get_townhall_email(get_townhall_urls)
  end

  def get_townhall_email(townhall_url)
    my_hash = {}
    a = []
    townhall_url.each do |url|
      page = Nokogiri::HTML(URI.open(url)) 

      ville = page.xpath("/html/body/div[1]/main/section[1]/div/div/div/h1").text
      email = page.xpath("/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]").text
      a << my_hash[ville] = email
    end

    return a
  end

  def get_townhall_urls
    page = Nokogiri::HTML(URI.open("http://www.annuaire-des-mairies.com/bas-rhin.html"))

    ville = []
    page.xpath('//a[contains(@href, "67")]').each do |element|
      ville << "https://www.annuaire-des-mairies.com/" + element.attributes["href"].value.gsub('./', '/')
    end

    return ville
  end

  def save_as_json
    File.open("db/emails.json","w") do |f|
      f.write(@list.to_json)
    end
  end

  def save_as_csv
    CSV.open("db/emails.csv", "w") do |csv|
      @list.each do |k,v|
        csv << [k,v]
      end
    end
  end

  def perform 
    puts get_townhall_email(get_townhall_urls)
  end

end