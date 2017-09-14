class Merchant

  attr_reader :id,
              :name,
              :parent

  def initialize(information, parent = nil)
    @id = information[:id]
    @name = information[:name]
    @parent = parent
  end

  def items
    sales_engine = @parent.parent
    sales_engine.items_repository.find_all_by_merchant_id(@id)
  end

end
