require 'time'
class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at

  def initialize(data, sales_engine)
    @sales_engine = sales_engine
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
  end

  def items
    items = @sales_engine.items.find_all_by_merchant_id(self.id)
    items
  end

  def invoices
    @sales_engine.invoices.find_all_by_merchant_id(self.id)
  end

  def customers
    invoices.map do |invoice|
      @sales_engine.customers.find_by_id(invoice.customer_id)
    end.uniq
  end

end
