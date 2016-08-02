class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(invoice_details, repo = nil)
    @id          = invoice_details[:id].to_i
    @customer_id = invoice_details[:customer_id].to_i
    @merchant_id = invoice_details[:merchant_id].to_i
    @status      = invoice_details[:status].to_s.to_sym
    @created_at  = format_time(invoice_details[:created_at].to_s)
    @updated_at  = format_time(invoice_details[:updated_at].to_s)
    @parent      = repo
  end

  def format_time(time_string)
    unless time_string == ""
      Time.parse(time_string)
    end
  end

  def merchant
    @parent.find_merchant_by_merchant_id(@merchant_id)
  end

  def items
    invoice_items.map do |invoice_item|
      @parent.find_item_by_item_id(invoice_item.item_id)
    end
  end

  def invoice_items
    @parent.find_invoice_items_by_invoice_id(id)
  end

  def get_item_quantity(item_id)
    invoice_items = get_invoice_items
    invoice_items.find do |invoice_item|
      invoice_item.item_id == item_id
    end.quantity
  end

  def transactions
    @parent.find_transactions_by_invoice_id(id)
  end

  def customer
    @parent.find_customer_by_customer_id(customer_id)
  end

  def is_paid_in_full?
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
    invoice_items.reduce(0) do |result, invoice_item|
      result += (invoice_item.unit_price).floor(2)  * invoice_item.quantity
      result
    end
  end

end
