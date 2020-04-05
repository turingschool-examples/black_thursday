class SalesEngine

def self.from_csv(params)
 # file_location.each do |repository, file_path|
    items = ItemsRepo.new(params[:items])
    merchants = MerchantRepo.new(params[:merchants])
    # binding.pry
end

def merchants
  @merchants ||=MerchantRepo.new.tap do |merchant_repo|
    merchant_repo.populate(@data[:merchants])
  end
end

# def merchants
#   merchants
# end
 # looked over my notes. two suggestions:

# 1. Create a key/value pair for the objects that are being sourced in a given CSV file, and the relative URL.
# Pass that key/value pair (as a hash) into the "load data" method,
# and it can read the key and send the CSV data to the right repository.


#merchants method populates your merchant repo
# in the merchant repo you can search by parameters
# all just returns everything
# so here we just iterate over all our merchant data and put it in merchants
end
