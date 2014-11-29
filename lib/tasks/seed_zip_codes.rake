namespace:db do
  desc "import zip codes and geolocations"
  task :name => :environment do
    Location.copy_from 'db/cityzip.csv'
  end
end
