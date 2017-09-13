require './lib/merchant_repository'

class Merchant
attr_reader :id, :name, :sales_engine
attr_accessor :items

  def initialize(info, sales_engine = "string")
    @id = info[:id]
    @name = info[:name]
    @sales_engine = sales_engine
    @items = []
  end

  def gather_items
    @items = @sales_engine.items.find_all_by_merchant_id(@id)
  end
end
