require 'csv'

class ItemRepository #< SalesEngine
  def initialize(items)
    @item_instances = items 
  end
end
