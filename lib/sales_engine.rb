require 'csv'
require 'pry'
class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(locations)
    @merchants = MerchantRepository.new(locations[:merchants])
    @items = ItemRepository.new(locations[:items])
  end

  def self.from_csv(locations)
    SalesEngine.new(locations)
  end

end
