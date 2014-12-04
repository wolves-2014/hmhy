# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
require 'time'

start_time = Time.now
puts "Seeding start time: #{start_time}"

primary_feelings = ["tired", "unfocused", "ashamed", "inadequate", "stuck", "overwhelmed", "afraid"]

secondary_feelings = ["sleeping too much", "not sleeping enough", "no appetite", "avoiding complicated tasks",
                      "guilty", "restless", "strained relationships"]
tertiary_feelings =["feeling hopeless", "indecisive", "often think about death", "numb", "irritable", "edgy", "tense", "easily distracted", "forgetful",
                    "often losing things", "making careless mistakes", "losing control when eating", "disliking own body",
                     "thinking about weight too much", "exercising too much", "dieting too much", "lost someone important",
                     "like I'm a slave to something", "wasting time on chasing something"]

primary_feeling_objects = primary_feelings.map do | feeling |
  Feeling.create!(word: feeling, rank: 1)
end

secondary_feeling_objects = secondary_feelings.map do | feeling |
  Feeling.create!(word: feeling, rank: 2)
end

tertiary_feeling_objects = tertiary_feelings.map do | feeling |
  Feeling.create!(word: feeling, rank: 3)
end

assessments = ["depression", "addiction", "adhd", "eating disorders", "grief", "anxiety"]

assessments.map!{|assessment| Assessment.create!(word: assessment)}

assessments[0].indications.create!(
  [{feeling: primary_feeling_objects[0]},
  {feeling: primary_feeling_objects[1]},
  {feeling: primary_feeling_objects[2]},
  {feeling: primary_feeling_objects[3]},
  {feeling: primary_feeling_objects[4]},
  {feeling: primary_feeling_objects[5]},
  {feeling: primary_feeling_objects[6]},
  {feeling: secondary_feeling_objects[0]},
  {feeling: secondary_feeling_objects[2]},
  {feeling: secondary_feeling_objects[3]},
  {feeling: tertiary_feeling_objects[0]},
  {feeling: tertiary_feeling_objects[1]},
  {feeling: tertiary_feeling_objects[2]},
  {feeling: tertiary_feeling_objects[3]}]
  )

assessments[1].indications.create!(
  [{feeling:primary_feeling_objects[1]},
  {feeling: primary_feeling_objects[2]},
  {feeling: primary_feeling_objects[3]},
  {feeling: primary_feeling_objects[5]},
  {feeling: primary_feeling_objects[6]},
  {feeling: secondary_feeling_objects[0]},
  {feeling: secondary_feeling_objects[1]},
  {feeling: secondary_feeling_objects[4]},
  {feeling: secondary_feeling_objects[6]},
  {feeling: tertiary_feeling_objects[17]},
  {feeling: tertiary_feeling_objects[18]}]
  )

assessments[2].indications.create!(
  [{feeling: primary_feeling_objects[1]},
  {feeling: secondary_feeling_objects[3]},
  {feeling: secondary_feeling_objects[5]},
  {feeling: tertiary_feeling_objects[7]},
  {feeling: tertiary_feeling_objects[8]},
  {feeling: tertiary_feeling_objects[9]},
  {feeling: tertiary_feeling_objects[10]}]
  )

assessments[3].indications.create!(
  [{feeling: primary_feeling_objects[0]},
  {feeling: primary_feeling_objects[2]},
  {feeling: primary_feeling_objects[3]},
  {feeling: primary_feeling_objects[4]},
  {feeling: secondary_feeling_objects[2]},
  {feeling: secondary_feeling_objects[4]},
  {feeling: secondary_feeling_objects[6]},
  {feeling: tertiary_feeling_objects[11]},
  {feeling: tertiary_feeling_objects[12]},
  {feeling: tertiary_feeling_objects[13]},
  {feeling: tertiary_feeling_objects[14]},
  {feeling: tertiary_feeling_objects[15]}]
  )

assessments[4].indications.create!(
  [{feeling: primary_feeling_objects[0]},
  {feeling: primary_feeling_objects[6]},
  {feeling: secondary_feeling_objects[0]},
  {feeling: tertiary_feeling_objects[16]}]
  )

assessments[5].indications.create!(
  [{feeling: primary_feeling_objects[0]},
  {feeling: primary_feeling_objects[1]},
  {feeling: primary_feeling_objects[4]},
  {feeling: primary_feeling_objects[6]},
  {feeling: secondary_feeling_objects[1]},
  {feeling: secondary_feeling_objects[5]},
  {feeling: tertiary_feeling_objects[4]},
  {feeling: tertiary_feeling_objects[5]},
  {feeling: tertiary_feeling_objects[6]}]
  )

Location.copy_from 'db/us_postal_codes.csv'

locations = Location.near(60606.to_s, 500).to_a

CSV.readlines("db/health_insurance_companies.csv").each do |line|
  Insurance.create!(name: line[0])
end


Insurance.create!(name: "Out of Network")

ages = ["Adolescents / Teenagers (14 to 19)", "Adults", "Elders (65+)", "Children (6 to 10)", "Preteens / Tweens (11 to 13)", "Toddlers / Preschoolers (0 to 6)"]

ages.each do |age|
  AgeGroup.create!(generation: age)
end

def check_price_range(string)
  unless string.nil?
    min_max_array = string.scan(/\d{2,}/)
    min_max_array.count == 2 ? min_max_array : [min_max_array[0], min_max_array[0]]
  else
    return ["0","0"]
  end
end

@filename = "db/new_therapists.csv"
# @filename = "db/therapists_in_60000.csv"
counter = 0
CSV.readlines(@filename, headers: true, header_converters: :symbol).each do |line|
  if location = Location.find_by(zip_code: line[:zip])
    price_range_array = check_price_range(line[:price_range])
    new_provider = location.providers.new(
      title: line[:title],
      name: line[:name],
      photo_url: line[:prof_image_url],
      profile_url: line[:profile_url],
      email: "help@example.com",
      phone_number: (line[:phone] == "" ? "(555) 555-5555" : line[:phone]),
      sliding_scale: if line[:sliding_scale] != nil then (line[:sliding_scale].downcase == "yes" ? true : false) else false end,
      min_price: price_range_array[0].to_i,
      max_price: price_range_array[1].to_i
      )
    new_provider.save(validate: false)

    ## Create Competencies
    valid_competencies = []
    all_competencies = JSON.parse line[:specialities]
    all_competencies.each do |competency|
      if matched_competency = competency[/Depression|Anxiety|Grief|ADHD|Eating Disorders|Addiction/]
        valid_competencies << matched_competency.downcase
      end
    end
    unless valid_competencies == []
      valid_competencies.uniq.each do |competency|
        assessment = Assessment.find_by(word: competency)
        competency = new_provider.competencies.new(assessment: assessment)
        competency.save(validate: false)
      end
    end

    ## Create networks
    valid_networks = []
    if line[:accepted_insurance] != nil
      all_networks = JSON.parse line[:accepted_insurance]
      all_networks.each do |network|
        if matched_network = network[/AARP|Aetna|Affinity|AFLAC|Alliance|ALTA|Altius|American Family|American Medical Security|American National|Amerigroup|AmeriHealth HMO|Ameritas|Arnett|Assurant|Asuris|Atlantis|Bankers Life and Casualty|BlueCross and BlueShield|Camrails a|Celtic|Centene|Cigna|Clear Choice|Cobalt|Companion|ConnectiCare|Conseco|Coventry|Cox|EmblemHealth|Fairmont|First Choice|FiServ|Fortis|GHI|Golden Rule|Great-West|Group Health Cooperative|Health Net|Health Plan Adminstrators|HealthAmerica|HealthMarkets|HealthPartners|HealthSpring|Highma|HIP|Humana|IHC|Kaiser Permanente|Kaleida|KPS|LifeWise|Medica|Medical Mutual of Ohio|MEGA|Mercy Health Plans of MO|Midwest Security|Molina|Mutual of Omaha|MVP|Neighborhood|ODS|OmniCare|Oxford|PacifiCare|PacificSource|Principal Financial Group|Providence|Rocky Mountain|Security Life|SelectHealth|Shelter|Sierra|Significa|Standard Security|State Farm|SummaCare|Thrivent|Time|Tricare|TUFTS|UNICARE|United Wisconsin|UnitedHealth Group|UnitedHealthcare|UnitedHealthOne|Unitrin|Unity|Univera|Universal American Corporation|VISTA|WellCare|Wellpath Select|WellPoint|WPS Health Insurance of Wisconsin|YKP/]
          valid_networks << matched_network
        end
      end
    end
    unless valid_networks == []
      valid_networks.uniq.each do |network|
        insurance = Insurance.find_by(name: network)
        network = new_provider.networks.new(insurance: insurance)
        network.save(validate: false)
      end
    else
      new_provider.networks.create!(insurance: Insurance.find_by(name: "Out of Network") )
    end

    ## Create Targets
    valid_targets = []
    if line[:age_range] !=nil
      all_targets = JSON.parse line[:age_range]
      all_targets.each do |target|
        if matched_target = target[/Adolescents \/ Teenagers \(14 to 19\)|Adults|Elders \(65\+\)|Children \(6 to 10\)|Preteens \/ Tweens \(11 to 13\)|Toddlers \/ Preschoolers \(0 to 6\)/]
          valid_targets << matched_target
        end
      end
    end
    unless valid_targets == []
      valid_targets.uniq.each do |target|
        age_group = AgeGroup.find_by(generation: target)
        target = new_provider.targets.new(age_group: age_group)
        target.save(validate: false)
      end
    end

    counter += 1
    if counter % 1000 == 0
      elapsed_time = Time.now - start_time
      puts "Creating entry for Psychology Today user: #{line[0]} | Time elapsed : #{(elapsed_time/60).floor} minutes and #{(elapsed_time%60).floor} seconds"
    end
  end

end
