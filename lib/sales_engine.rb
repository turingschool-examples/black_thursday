require_relative './csv_adaptor'
require_relative './merchant_repo'
require_relative './item_repo'

class SalesEngine
  attr_reader :merchants, :items

  extend CsvAdaptor

  def initialize(merchant_array, item_array)
    @merchants = MerchantRepo.new(merchant_array)
    @items = ItemRepo.new(item_array)
  end

  def self.from_csv(hash)
    merchant_file = hash[:merchants]
    item_file = hash[:items]

    merchant_array = load_from_csv(merchant_file)
    item_array = load_from_csv(item_file)
    SalesEngine.new(merchant_array, item_array)
  end

end


# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
# mr = se.merchants
# merchant = mr.merchant_hashes_to_objects()
# p merchant
