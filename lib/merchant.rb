require 'time'

class Merchant

  attr_reader :id,
              :name,
              :parent,
              :created_at

  def initialize(information, parent = nil)
    @id = information[:id]
    @name = information[:name]
    @parent = parent
    @created_at = Time.parse(information[:created_at])
  end

  def items
    sales_engine = @parent.parent
    sales_engine.items.find_all_by_merchant_id(@id)
  end

  def invoices
    sales_engine = @parent.parent
    sales_engine.invoices.find_all_by_merchant_id(@id)
  end

  def customers
    se = @parent.parent
    customer_ids = invoices.map { |invoice| invoice.customer_id }
    customer_ids.map { |customer_id| se.customers.find_by_id(customer_id) }.uniq
  end

  def total_revenue
    return 0 if invoices.empty?
    invoices.map do |invoice|
      invoice.total
    end.inject(:+).round(2)
  end

end
