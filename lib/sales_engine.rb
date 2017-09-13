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
    if @merchant_repository.nil? 
      @merchant_repository = MerchantRepository.new(@merchant_csv_filepath, self)
    else 
      @merchant_repository
    end 
  end

  def items
    if @item_repository.nil? 
      @item_repository = ItemRepository.new(@item_csv_filepath, self)
    else 
      @item_repository
    end 
  end

end
