require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine

  attr_reader :item,
              :merchant

  def initialize(csv_data)
    @item = ItemRepository.new()
    @merchant = MerchantRepository.new()
  end

  def self.from_csv(csv_data)
    SalesEngine.new(csv_data)
  end

  def method_name

  end

end
