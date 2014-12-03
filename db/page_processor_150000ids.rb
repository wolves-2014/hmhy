require 'open-uri'
require 'nokogiri'
require 'pry'
require 'csv'

def process_page(url)
  doc = Nokogiri(open(url))
  profile_url = url
  prof_image_url = process_image(doc)
  specialities = process_specialities(doc)
  name = process_name(doc)
  title = process_title(doc)
  phone = process_phone(doc)
  zip = process_zip(doc)
  ages = process_age(doc)
  price_range = process_price_range(doc)
  sliding_scale = process_sliding_scale(doc)
  accepted_insurance = process_insurance(doc)
  if zip != nil
    CSV.open("new_therapists.csv", "a") do |csv|
      csv << [@id,title, name, prof_image_url, profile_url, phone, zip, specialities, ages, price_range, sliding_scale, accepted_insurance]
    end
    puts @id
    CSV.open("stdout.csv", "a") do |csv|
      csv << [@id]
    end
  end
  rescue OpenURI::HTTPError => e
  if e.message
    CSV.open("stdout.csv", "a") do |csv|
      csv << ["#{@id} - #{e.message}"]
    end
    puts "#{@id} - #{e.message}"
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
  doc.xpath('//span[@itemprop = "postalcode"]')[0].nil? ? nil : doc.xpath('//span[@itemprop = "postalcode"]')[0].text
end

def process_specialities(doc)
  specs = []
  doc.xpath('//div[@class = "section profile-spec_zone_2"]/div[@class = "spec-list clearfix"]/div/ul/li').each {|li| specs << li.text }
  return specs
end

def process_age(doc)
  div = nil
  doc.xpath('//div[@class = "section profile-spec_zone_4"]/div/h3').each {|h3| div = h3.parent if h3.text == "Age:"}
  div.nil? ? nil : div.xpath('.//li').map { |li| li.text }
end

def process_price_range(doc)
  div = doc.xpath('//div[@class = "section profile-finances"]')
  avg_cost_li = div.xpath('.//li').select {|li| li.text.include?("Avg Cost ") }
  if avg_cost_li.empty?
    return nil
  else
    avg_cost = avg_cost_li[0].text
    avg_cost.slice!("Avg Cost (per session): ")
    return avg_cost
  end
end

def process_sliding_scale(doc)
  div = doc.xpath('//div[@class = "section profile-finances"]')
  sliding_scale_li = div.xpath('.//li').select {|li| li.text.include?("Sliding Scale:") }
  if sliding_scale_li.empty?
    return nil
  else
    ss = sliding_scale_li[0].text
    ss.slice!("Sliding Scale: ")
    return ss
  end
end

def process_insurance(doc)
  insurance_h3 = doc.xpath('//div[@class = "section profile-finances"]/div/div/h3').select {|h3| h3.text == "Accepted Insurance Plans:"}
  if insurance_h3.empty?
    return nil
  else
    insurance_list = insurance_h3[0].parent
    accepted_insurance = insurance_list.xpath('.//li').map { |li| li.text }
    return accepted_insurance
  end
end


CSV.readlines("therapists_150000ids.csv").each do |line|
  @id = line[0].to_i
  url = "http://therapists.psychologytoday.com/rms/prof_detail.php?profid=#{@id}"
  sleep(0.5)
  process_page(url)
end


