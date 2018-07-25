require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'

class SalesEngine
  
  include CsvAdaptor

  def initialize
    @merchants = MerchantRepo.new(from_csv)
    @items = ItemRepo.new(from_csv)
  end

  def from_csv(file_location)
    load_from_csv(file_location)
  end

end

# 
# sa = SalesEngine.new 
# se = sa.from_csv("./data/items.csv")
# mr = se.merchants
# 
# p mr


