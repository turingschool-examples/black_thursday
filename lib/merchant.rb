require 'pry'

class Merchant
  attr_reader :id,
              :name,
              :parent,
              :created_at

  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = Time.parse(data[:created_at])
    @parent = parent
  end

  def items
    parent.call_items_from_merchant_id(id)
  end

  def invoices
    parent.call_invoices_from_merchant_id(id)
  end

  def customers
    parent.call_customers_from_merchant_id(id)
  end

end
