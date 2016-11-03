class Merchant

  attr_reader :id,
              :name,
              :parent

  def initialize(data, parent = nil)
    @id = data[:id].to_i
    @name = data[:name]
    @parent = parent
  end

  def items
    SalesEngine.items.find_all_by_merchant_id(id)
  end

  def invoices
    parent.find_invoices(id)
  end

end