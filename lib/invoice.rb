class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

  def merchant
    parent.call_merchant_from_merchant_id(merchant_id)
  end

  def items
   parent.call_items_from_invoice_id(id)
  end

  def transactions
    parent.call_transactions_from_invoice_id(id)
  end

  def customer
    parent.call_customer_from_customer_id(customer_id)
  end

  def is_paid_in_full?
    parent.invoice_paid_in_full?(id)
  end

  def total
    parent.invoice_total(id)
  end

end
