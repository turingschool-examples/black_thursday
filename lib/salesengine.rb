require 'csv'

class SalesEngine
  attr_reader :items, :merchants
  #
  def initialize(se_hash)
    @items = ItemRepository.new(se_hash[:item])
    @merchants = MerchantRepository.new(se_hash[:merchant])
  end

  def self.from_csv(se_hash)
    Salesengine.new(se_hash)
  end
    #I called self bc per the spec it looks like it will call on itself.
    #I can explain in class if need be

  # se = SalesEngine.from_csv({
  # :items     => "./data/items.csv",
  # :merchants => "./data/merchants.csv",})
  #
  # From there we can find the child instances:
  #
  # items returns an instance of ItemRepository with all the item instances loaded
  # merchants returns an instance of MerchantRepository with all the merchant instances loaded
  #
end
