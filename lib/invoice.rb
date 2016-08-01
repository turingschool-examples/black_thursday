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
    @status      = invoice_details[:status]
    # @created_at  = format_time(invoice_details[:created_at].to_s)
    # @updated_at  = format_time(invoice_details[:updated_at].to_s)
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
    invoice_items = @parent.find_invoice_items_by_invoice_id(id)
    invoice_items.map do |invoice_item|
      @parent.find_item_by_item_id(invoice_item.item_id)
    end
  end

  def transactions
    @parent.find_transactions_by_invoice_id(id)
  end

  def customer
    # binding.pry
    @parent.find_customer_by_customer_id(customer_id)
  end

  def is_paid_in_full?
    transactions.one? do |transaction|
      transaction.status == "success"
    end
  end

  def total
    items.reduce(0) do |result, item|
      result += item.unit_price
      result
    end
  end

end
