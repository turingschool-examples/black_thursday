require 'csv'
require 'pry'
require_relative './merchant_repository'
require_relative './item_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(sales_data)
    @items = ItemRepository.new(sales_data[:items], self)
    @merchants = MerchantRepository.new(sales_data[:merchants], self)
  end

  def self.from_csv(sales_data)
    SalesEngine.new(sales_data)
  end
end
