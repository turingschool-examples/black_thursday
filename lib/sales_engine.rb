require 'csv'

class SalesEngine
  def self.from_csv(hash)
    # make an items repository instance using hash[:items] path

    # make a merchants repository instance using hash[:merchants] path
    MerchantRepository.new(hash[merchants])
    
  end
end

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
