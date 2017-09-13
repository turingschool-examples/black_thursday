require './lib/merchant_repository'

class Merchant
attr_reader :id, :name, :sales_engine
attr_accessor :items

  def initialize(info, merchant_repository = "string")
    @id = info[:id]
    @name = info[:name]
    @merchant_repository = merchant_repository
    @items = []
  end

 def items
  @merchant_repository.sales_engine.items.find_all_by_merchant_id(@id)
 end 
 
  # def gather_items
  #   @items = @sales_engine.items.find_all_by_merchant_id(@id)
  # end
end
