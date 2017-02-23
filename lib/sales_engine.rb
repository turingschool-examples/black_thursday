require_relative './item_repository'
require_relative './merchant_repository'

class SalesEngine

  attr_accessor :items, :merchants

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end
end


# se = SalesEngine.from_csv({
#   :items     => "./test/fixtures/item_fixture.csv",
#   :merchants => "./test/fixtures/merchant_fixture.csv",
# })
#
# require "pry"; binding.pry
# p ""
