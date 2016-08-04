class Merchant
  attr_reader :id, :name, :parent

  def initialize(data, parent = nil)
    @id =   data[:id].to_i
    @name = data[:name]
    @parent = parent
  end

  def items
    @parent.find_all_items_by_merchant_id(@id)
  end

  def invoices
    @parent.find_all_invoices_by_merchant_id(@id)
  end

  def customers
    @parent.find_all_customers_by_merchant_id(@id)
  end
end
