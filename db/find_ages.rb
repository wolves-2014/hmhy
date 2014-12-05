require 'csv'
require 'pry'
require 'json'

@filename = "temp_therapists.csv"
all_ages = []
CSV.readlines(@filename).each do |line|
  unless line[8] == nil
    age_array = JSON.parse line[8]
    all_ages << age_array
  end
end
all_ages.flatten!.compact!.uniq!
puts all_ages
