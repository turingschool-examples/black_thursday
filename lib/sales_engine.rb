class SalesEngine


def initialize(data)
  @data = data
end

def self.from_csv(file_location)
 file_location.each do |repository, file_path|
    merchants = MerchantRepo.new(file_location[:merchants])
    items = ItemsRepo.new(file_location[:items])
   binding.pry
 #we need to return the hash now and maybe we can use explicit return or new (file_location)
 #if this doesn't work
 # data_from_csv
end


#merchants method populates your merchant repo
# in the merchant repo you can search by parameters
# all just returns everything
# so here we just iterate over all our merchant data and put it in merchants
end
