class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(invoice, parent=nil)
    @id          = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status      = invoice[:status].to_sym
    @created_at  = Time.parse(invoice[:created_at].to_s)
    @updated_at  = Time.parse(invoice[:updated_at].to_s)
    @parent      = parent
  end

  def merchant
    @parent.find_merchant_from_invoice(merchant_id)
  end

  def items
    @parent.find_items_by_invoice(id)
  end

  def transactions
    @parent.find_transactions_by_invoice(id)
  end

  def customer
    @parent.find_customer_by_invoice(customer_id)
  end

  def invoice_items 
    @parent.find_invoice_items(id)
  end

  def is_paid_in_full?
    transactions.any? { |transaction| transaction.result == "success"}
  end

  def total
    return 0 if !is_paid_in_full?
    invoice_items.reduce(0) do |sum, item|
      sum += (item.unit_price * item.quantity)
    end
  end
end