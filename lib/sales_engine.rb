require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize
    @merchants = MerchantRepository.new
    @items = ItemRepository.new
  end

  def self.from_csv(_hash_path)
    sales_engine = new
    rows = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
    rows.each do |row|
      new_merchant = Merchant.new(row.to_h)
      sales_engine.merchants.all << new_merchant
    end
    # require 'pry'; binding.pry
  end
end
