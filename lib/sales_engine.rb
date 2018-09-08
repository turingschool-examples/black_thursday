class SalesEngine


def initialize(data)
  @data = data
end

def self.from_csv(file_location)
 data_from_csv = {}
 file_location.each do |repository, file_path|
   data_from_csv[repository] = CSV.open(file_path, headers: true, header_converters: :symbol)
 end
 #we need to return the hash now and maybe we can use explicit return or new (file_location)
 #if this doesn't work
 data_from_csv
end


#merchants method populates your merchant repo
# in the merchant repo you can search by parameters
# all just returns everything 
end
