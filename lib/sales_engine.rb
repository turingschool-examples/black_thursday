require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'
require 'pry'

class SalesEngine
  attr_reader   :merchant_repository,
                :item_repository
                
  def initialize
    @merchant_data = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
    @item_data     = CSV.open './data/items.csv', headers: true, header_converters: :symbol
    @merchant_repository = MerchantRepository.new(@merchant_data, self)
    @item_repository     = ItemRepository.new(@item_data, self)
  end

  def find_all_items_by_merchant_id(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

end

se = SalesEngine.new
# binding.pry
merch_test = se.merchant_repository.find_by_id("12334105")
binding.pry