require 'open-uri'
require 'nokogiri'
require 'pry'
require 'csv'


def process_page(url)
  doc = Nokogiri(open(url))
  puts "#{@id}: #{Time.now}"
  profile_url = url
  prof_image_url = process_image(doc)
  specialities = process_specialities(doc)
  name = process_name(doc)
  title = process_title(doc)
  phone = process_phone(doc)
  zip = process_zip(doc)
  if zip != nil
    CSV.open("therapists.csv", "a") do |csv|
      csv << [@id,title, name, prof_image_url, profile_url, phone, zip, specialities]
    end
  end
  rescue OpenURI::HTTPError => e
    if e.message
      puts "#{@id}: #{Time.now} - #{e.message}"
      nil
    end
end

def process_image(doc)
  return doc.css("img")[0].attributes["src"].value
end

def process_name(doc)
  return doc.xpath('//div[@class = "section profile-name"]/h1').text
end

def process_title(doc)
  return doc.xpath('//div[@class = "profile-title"]').text.strip.gsub("\n", "")
end

def process_phone(doc)
  return doc.xpath('//div[@class = "section profile-phone"]').text.strip
end

def process_zip(doc)
  unless /\d{5}/.match(doc.xpath('//div[@itemprop = "address"]').text.strip) == nil
    return /\d{5}/.match(doc.xpath('//div[@itemprop = "address"]').text.strip)[0]
  end
end

def process_specialities(doc)
  specs = []
  doc.xpath('//div[@class = "section profile-spec_zone_2"]/div[@class = "spec-list clearfix"]/div/ul/li').each {|li| specs << li.text }
  return specs
end

@id = 175067
url = "http://therapists.psychologytoday.com/rms/prof_detail.php?profid=#{@id}"
process_page(url)

while @id < 220000
  seconds = 0.3
  puts "Sleeping for #{seconds} seconds..."
  sleep(seconds)
  url = "http://therapists.psychologytoday.com/rms/prof_detail.php?profid=#{@id}"
  process_page(url)
  @id += 1
end

