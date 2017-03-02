require_relative 'helper'

class Merchant
  attr_reader :id,
              :name,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @parent = parent
  end

  def items
    parent.find_items(id)
  end

  def invoices
    parent.find_invoices(id)
  end

  def customers
    parent.find_customers_by_merchant_id(id)
  end
end