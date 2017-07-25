require './lib/merchant_repo'
require './lib/item_repo'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants
  #
  def initialize(se_hash)
    @items = ItemRepository.new(se_hash[:item])
    @merchants = MerchantRepository.new(se_hash[:merchant])
  end

  def self.from_csv(se_hash)
    item_data = Item.load_data(se_hash[:items])
    merchant_data = Merchant.load_data(se_hash[:merchants])

    Salesengine.new(item_data, merchant_data)
  end

  def self.load_data(se_hash)
    CSV.open(se_path, headers: true)
  end
    #I called self bc per the spec it looks like it will call on itself.
    #I can explain in class if need be
    # Will this actually call it on self? I think the self right now is just part of the method name and not calling on the self. 

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
