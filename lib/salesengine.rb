require 'pry'
require 'csv'
require_relative 'itemrepository'
class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(item_path, merchant_path)
    @items = ItemRepository.new(item_path, self)
    @merchants = MerchantRepository.new(merchant_path)
  end

  def self.from_csv(file = {})
    SalesEngine.new(file[:items],file[:merchants])
  end

end
binding.pry
