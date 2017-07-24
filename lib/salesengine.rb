require 'csv'

class SalesEngine
  attr_reader :items, :merchants
  #
  def initialize(item, merchant)
    @items = ItemRepository.new
    @merchants = Merchant.new
  end


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
