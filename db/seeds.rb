# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

primary_feelings = ["tired", "unfocused", "ashamed", "inadequate", "stuck", "overwhelmed", "afraid"]
secondary_feelings = ["like I sleep too much", "like I don't sleep enough", "like I have no appetite", "like I avoid difficult tasks",
                      "guilty", "restless", "like my relationships are strained"]
tertiary_feelings =["hopeless", "indecisive", "obsessed with death", "numb", "irritable", "edgy", "tense", "easily distracted", "forgetful",
                    "like I always lose things", "like I make careless mistakes", "like I lose control when eating", "like I don't like my body", "like I think about my weight too much", "like I exercise too much", "like I diet too often", "like I lost someone important", "like I'm a slave to something", "like I've wasted too much of my time chasing something"]

primary_feeling_objects = primary_feelings.map! do | feeling |
  Feeling.create!(word: feeling)
end

secondary_feeling_objects = secondary_feelings.map! do | feeling |
  Feeling.create!(word: feeling)
end

tertiary_feeling_objects = tertiary_feelings.map! do | feeling |
  Feeling.create!(word: feeling)
end

assessments = ["depression", "addiction", "ADD", "eating disorder", "grief", "anxiety"]

assessments.map!{|assessment| Assessment.create!(word: assessment)}
binding.pry

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
  {feeling: tertiary_feeling_objects[4]},
  {feeling: tertiary_feeling_objects[5]},
  {feeling: tertiary_feeling_objects[6]}]
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
  {feeling: tertiary_feeling_objects[17]},
  {feeling: tertiary_feeling_objects[18]}]
  )

providers = []

20.times do
  providers << Provider.create!(
  title: Faker::Name.title,
  name: Faker::Name.name,
  photo_url: "http://lorempixel.com/150/200/cats/#{rand(1..10)}",
  profile_url: Faker::Internet.url,
  email: Faker::Internet.email,
  phone_number: Faker::PhoneNumber.phone_number)
end

providers.each do |provider|
  assessments = []
  2-5.times do
    assessments << Assessment.all.sample
  end
  assessments.uniq!
  assessments.each do |assessment|
    provider.competencies.create!(assessment: assessment)
  end
end

Location.copy_from 'db/cityzip.csv'
















