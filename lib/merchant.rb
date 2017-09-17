class Merchant
  attr_reader :id, :name, :sales_engine
  attr_accessor :items

  def initialize(info, merchant_repository)
    @id = info[:id].to_i
    @name = info[:name]
    @merchant_repository = merchant_repository
    @items = []
  end

 def items #refactor—make method in repo that hides sales engine and its stuff.
  #@merchant_repository.sales_engine.items.find_all_by_merchant_id(@id)
  @merchant_repository.find_all_by_merchant_id_in_item_repo(@id)
 end

 def invoices
  @merchant_repository.sales_engine.invoices.find_all_by_merchant_id(@id)
 end
end
