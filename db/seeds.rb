# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

feelings = ["numb","sad","depressed","lonely","anxious","stressed"]

feelings.map! do | feeling |
  Feeling.create!(word: feeling)
end

assessments = ["grief","addiction","anger","obsessive-compulsive","video game addiction","depression"]

assessments.map!{|assessment| Assessment.create(word: assessment)}

assessments[0].indications.create!(
  [{feeling: feelings[0]},
  {feeling: feelings[1]},
  {feeling: feelings[3]},
  {feeling: feelings[4]},
  {feeling: feelings[5]}]
  )

assessments[1].indications.create!(
  [{feeling: feelings[0]},
  {feeling: feelings[3]},
  {feeling: feelings[4]},
  {feeling: feelings[5]}]
  )

assessments[2].indications.create!(
  [{feeling: feelings[0]},
  {feeling: feelings[4]},
  {feeling: feelings[5]}]
  )

assessments[3].indications.create!(
  [{feeling: feelings[4]},
  {feeling: feelings[5]}]
  )

assessments[4].indications.create!(
  [{feeling: feelings[1]},
  {feeling: feelings[3]},
  {feeling: feelings[4]}]
  )

assessments[5].indications.create!(
  [{feeling: feelings[0]},
  {feeling: feelings[1]},
  {feeling: feelings[3]},
  {feeling: feelings[4]}]
  )

