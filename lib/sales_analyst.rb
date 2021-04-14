require './lib/sales_engine'

class SalesAnalyst
  attr_reader :merchants,
              :items
              
  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end
end
