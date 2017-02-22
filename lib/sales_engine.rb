require 'csv'
require 'pry'
require_relative 'merchant_repository'

class SalesEngine
  attr_reader :data
  def initialize(data)
    @data = data
  end
  def self.from_csv(info)
    self.new(info)
    #items = info[:items]
    # merchants = info[:merchants]
  end

  def items
    items_csv = CSV.open data[:items], headers: true, header_converters: :symbol
    ItemRepository.new(items_csv)
  end

  def merchants
    merchants_csv = CSV.open data[:merchants], headers: true, header_converters: :symbol
    MerchantRepository.new(merchants_csv)
  end

end

se = SalesEngine.from_csv({
    :merchants    => "./data/temp_merchants.csv",
    })
merch = se.merchants
merch.all
binding.pry
""
