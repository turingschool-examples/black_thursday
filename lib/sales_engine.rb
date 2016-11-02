require './lib/merchant_repository'
require 'csv'
require './lib/item_repository'
require 'pry'

class SalesEngine
  attr_reader   :merchant_repository,
                :item_repository
                
  def initialize(file = nil)
    @merchant_data = SalesEngine.from_csv({:merchants => file })
    @item_data     = SalesEngine.from_csv({:items => file })
    @merchant_repository = MerchantRepository.new(@merchant_data, self)
    @item_repository     = ItemRepository.new(@item_data, self)
  end

  def find_all_items_by_merchant_id(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

  def self.from_csv(file = nil)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.each do |row|
      return row
  end

  def items(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id).map { |item| item["name"]}
  end


  def merchant(name)
    merch_ids = item_repository.find_all_by_name(name).map { |item| item["merchant_id"] }
    merchants = merch_ids.map { |merch_id| merchant_repository.find_by_id(merch_id)["name"] }
    merchants
  end
  end

end

# se = SalesEngine.new
# # binding.pry
# merch_test = se.merchant_repository.find_by_id("12334105")
# binding.pry