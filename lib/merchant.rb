class Merchant
  attr_reader :name,
              :id,
              :created_at,
              :updated_at

  def initialize(row, parent = nil)
    @id         = row[:id].to_i
    @name       = row[:name].to_s
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
    @parent     = parent
  end

  def items
    @parent.find_items_by_merchant_id(id)
  end

  def invoices
    @parent.find_invoices_by_merchant_id(id)
  end

  def customers
    invoices = @parent.find_invoices_by_merchant_id(id)
    invoices.map do |invoice|
      @parent.find_customer_by_customer_id(invoice.customer_id)
    end.uniq
  end
end
