require './lib/merchant_repository'

# require './lib/items'

class SalesEngine

  def self.from_csv(hash)
    
    # require "pry"; binding.pry
  end

  def self.merchants
    @MerchantRepository = MerchantRepository.new(true)
  end

  def self.items
  end
end
#   se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv"
# })
#
# ir   = se.items
# item = ir.find_by_name("Item Repellat Dolorum")
# # => <Item>
