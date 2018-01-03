require 'pry'
require_relative 'merchant_repo'
require_relative 'item_repo'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @items = ItemRepo.new(data[:items], self)
    @merchants = MerchantRepo.new(data[:merchants], self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

end
