require "csv"
require './lib/merchant_repository'

class SalesEngine
  def self.from_csv(data_files)
    SalesEngine.new
  end

  def merchants
    MerchantRepository.new   
  end
end



# CSV.open "./data/merchants.csv"
# items: CSV.open "./data/items.csv"}

# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
