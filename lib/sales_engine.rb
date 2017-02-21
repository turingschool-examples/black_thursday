class SalesEngine

  def self.from_csv(hash)
    #make an item repository using hash[:items] path
    #make a merchants repository using hash[:merchants] path
    
    MerchantRepository.new(hash[merchants])
  end
end

# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
