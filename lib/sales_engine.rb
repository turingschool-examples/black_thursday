require 'csv'
require_relative 'merchant_repository'
class SalesEngine
  attr_reader :item_csv
  def initialize
    @item_csv = ''
    @merchant_csv = ''
  end

  def from_csv(csv_hash)
    @item_csv = CSV.read csv_hash[:items]
    @merchant_csv = CSV.read csv_hash[:merchants]
  end

  def items
    ItemRepository.new(@item_csv)
  end

  def merchants
    MerchantRepository.new(@merchant_csv)
  end
  
end

sales =  SalesEngine.new

sales.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"})
