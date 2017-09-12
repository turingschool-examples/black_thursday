require './lib/merchant_repository'
require './lib/item_repository'
class SalesEngine
  
  attr_accessor :merchant_csv_filepath, :item_csv_filepath

  def self.from_csv(info)
    se = SalesEngine.new
    se.merchant_csv_filepath = info[:merchants]
    se.item_csv_filepath = info[:items]
    se
  end
  
  def initialize
    @merchant_csv_filepath = ''
    @item_csv_filepath = ''
  end 

  def merchants
    MerchantRepository.new(@merchant_csv_filepath, self)
  end

  def items
    ItemRepository.new(@item_csv_filepath, self)
  end
end
