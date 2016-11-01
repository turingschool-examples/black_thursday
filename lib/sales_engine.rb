require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesEngine
  attr_reader   :merchant_repository,
                :item_repository
                
  def initialize
    @merchant_data = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
    @item_data     = CSV.open './data/items.csv', headers: true, header_converters: :symbol
    @merchant_repository = MerchantRepository.new(@merchant_data, self)
    @item_repository     = ItemRepository.new(@item_data, self)
  end

end

a = SalesEngine.new
puts a.item_repository.find_all_by_name("lets")[1]["name"]