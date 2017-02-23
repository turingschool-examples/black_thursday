require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'

class SalesEngine
  attr_reader :item_csv, :merchant_csv

  def self.from_csv(csv_hash)
    @item_csv = CSV.open csv_hash[:items], headers: true, header_converters: :symbol
    @merchant_csv = CSV.open csv_hash[:merchants], headers: true, header_converters: :symbol
  end

  def items
    ItemRepository.new(@item_csv, self).make_repository
  end

  def merchants
    MerchantRepository.new(@merchant_csv, self).make_merchant_repository
  end

end

sales =  SalesEngine.new

sales.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"})


se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

mr = se.merchants
merchant = mr.find_by_name("CJsDecor")
