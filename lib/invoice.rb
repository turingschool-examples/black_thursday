class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent = nil)
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status = attributes[:status].to_sym
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    @parent = parent
  end

  def merchant
    parent.parent.merchants.find_by_id(merchant_id)
  end

  def items
    item_ids = parent.parent.invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      invoice_item.item_id
    end
    item_ids.map do |id|
      parent.parent.items.find_by_id(id)
    end
  end

  def transactions
    parent.parent.transactions.find_all_by_invoice_id(id)
  end

  def customer
    parent.parent.customers.find_by_id(customer_id)
  end

  def is_paid_in_full?
    return false if transactions.empty?
    transactions.each do |transaction|
      return false if transaction.result != "success"
    end
    return true
  end

  def invoice_item
    parent.find_invoice_items_by_invoice(id)

  end

  def total
    if is_paid_in_full?
      invoice_item = parent.parent.invoice_items.find_all_by_invoice_id(id)
      invoice_item.reduce(0) { |sum, item| sum + (item.unit_price * item.quantity) }
    end
  end


end
