require 'csv'
require 'pry'
require 'json'

@filename = "temp_therapists.csv"
all_insurances = []
CSV.readlines(@filename).each do |line|
  unless line[11] == nil
    insurance_array = JSON.parse line[11]
    all_insurances << insurance_array
    puts insurance_array
  end
end
binding.pry
all_insurances.flatten!.compact!.uniq!
puts all_insurances
