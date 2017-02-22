require 'csv'

class SalesEngine

  attr_accessor :items, :merchants

  def self.from_csv(hash)
    @items = ItemRepository.new(hash[items])
    @merchants = MerchantRepository.new(hash[merchants])
  end
end

# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
