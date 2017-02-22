require 'csv'
require_relative 'merchant_repository'
class SalesEngine
  def initialize
    @item_csv = ''
    @merchant_csv = ''
  end

  def from_csv(csv_hash)
    @item_csv = CSV.open csv_hash[:items]
    @merchant_csv = CSV.open csv_hash[:merchants]
  end

  def items
    ItemRepository.new(@item_csv)
  end

  def merchants
    MerchantRepository.new(@merchant_csv)
  end
  
end