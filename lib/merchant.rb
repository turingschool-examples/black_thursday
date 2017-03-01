class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(row, parent)
    @id = row[:id].to_i
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @parent = parent
  end

  def items
    parent.engine.items.find_all_by_merchant_id(id)
  end

  def invoices
    parent.engine.invoices.find_all_by_merchant_id(id)
  end

  def customers  #need longer method to traverse and match correct data
    parent.engine.invoices.find_all_by_customer_id(customer_id)
  end
end
