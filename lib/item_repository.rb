require 'bigdecimal'

class ItemRepository
  attr_reader       :item_details

  def initialize(items)
    @items =  items
  end

end
