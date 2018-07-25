require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'

class SalesEngine
  attr_reader :merchants, :items

  extend CsvAdaptor

  def initialize(merchant_hashes, item_hashes)
    @merchants = MerchantRepo.new(merchant_hashes)
    @items = ItemRepo.new(item_hashes)
  end

  def self.from_csv(file_location)
    merchant_file = file_location[:merchants]
    item_file = file_location[:items]

    merchant_hashes = self.load_from_csv(merchant_file)
    item_hashes = self.load_from_csv(item_file)

    SalesEngine.new(merchant_hashes, item_hashes)
  end

end

#
# sa = SalesEngine.new
# se = sa.from_csv("./data/items.csv")
# mr = se.merchants
#
# p mr
