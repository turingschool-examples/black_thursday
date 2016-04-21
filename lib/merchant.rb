
class Merchant
  attr_reader :id, :name, :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @name = data[:name]
    @sales_engine = sales_engine
  end

  def items
    sales_engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    sales_engine.invoices.find_all_by_merchant_id(id)
  end

end
