class Invoice

attr_reader :id,
            :customer_id,
            :merchant_id,
            :status,
            :created_at,
            :updated_at

  def initialize(invoice, invoice_repo_parent = nil)
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status].to_sym
    @created_at = Time.parse(invoice[:created_at])
    @updated_at = Time.parse(invoice[:updated_at])
    @parent = invoice_repo_parent
  end

  def merchant
    @parent.parent.merchants.find_by_id(@merchant_id)
  end

  def day_created
    day = created_at.wday
    case day
      when 0 then 'Sunday'
      when 1 then 'Monday'
      when 2 then 'Tuesday'
      when 3 then 'Wednesday'
      when 4 then 'Thursday'
      when 5 then 'Friday'
      when 6 then 'Saturday'
    end
  end

  def items 
    @invoice_items = @parent.parent.invoice_items.find_all_by_invoice_id(@id)
    all_items = @invoice_items.map do |invoice_item| 
      @parent.parent.items.find_by_id(invoice_item.item_id)
    end 
    all_items
  end

  def transactions
    @parent.parent.transactions.find_all_by_invoice_id(@id)
  end

  def customer
    @parent.parent.customers.find_by_id(@customer_id) 
  end

  def is_paid_in_full?
    transactions.any? do |transaction|
      transaction.result == "success"
    end

  end

  def total
    items
    @invoice_items.reduce(0) do |sum, item|
      sum + item.unit_price * item.quantity.to_f
    end.round(2)
  end
end
