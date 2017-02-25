class Merchant

  attr_reader :name, :id, :sales_engine

  def initialize(params, sales_engine)
    @name = params[:name]
    @id = params[:id].to_i
    @sales_engine = sales_engine
  end

  def items
    sales_engine.items.find_all_by_merchant_id(id)
  end
end