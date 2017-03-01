class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent = nil)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @parent = parent
  end

  def items
    parent.parent.items.find_all_by_merchant_id(id)
  end

  def invoices
    parent.parent.invoices.find_all_by_merchant_id(id)
  end

  def customers
    customer_ids = invoices.map do |invoice|
      invoice.customer_id
    end
    customer_ids.map { |id| parent.parent.customers.find_by_id(id) }.uniq
  end
end
