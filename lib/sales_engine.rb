require 'csv'
# require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/file_opener'

class SalesEngine
  extend FileOpener
  attr_reader :items,
              :merchants

  def self.from_csv(data_files)
    se = SalesEngine.new
    all_item_data = open_csv(data_files[:items] #self)
    @items = ItemRepository.new(all_item_data)
    @all_merchant_data = open_csv(data_files[:merchants])
    se
  end

  def items
  end

  # def merchants(filename)
  #   MerchantRepository.new(filename)
  # end
end

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

se.items
 # merchant = se.merchants.find_by_id(12334105)
 #
 # merchant.items

 # self.find_all_by_merchant_id(merchant_id)
