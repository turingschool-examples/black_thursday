require './lib/repository'

class ItemRepository < Repository
  attr_reader :items

  def initialize
    @items = []
    @collection = @items
  end

  def add_item(item)
    @items << item
  end

  # find_all_with_description(description)
  # find_all_by_price(price)
  # find_all_by_price_in_range(range)
  # find_all_by_merchant_id(merchant_id)
  

end
