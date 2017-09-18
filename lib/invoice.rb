class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(information, parent = nil)
    @id = information[:id]
    @customer_id = information[:customer_id]
    @merchant_id = information[:merchant_id]
    @status = information[:status].to_sym
    @created_at = Time.parse(information[:created_at].to_s)
    @updated_at = Time.parse(information[:updated_at].to_s)
    @parent = parent
  end

  def merchant
    sales_engine = @parent.parent
    sales_engine.merchants.find_by_id(@merchant_id)
  end

  def created_day
    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    weekday = @created_at.wday
    days[weekday]
  end

  def items
    sales_engine = @parent.parent
    inv_items = sales_engine.invoice_items.find_all_by_invoice_id(id)
    item_ids = inv_items.map do |invoice_item|
      invoice_item.item_id
    end
    item_ids.map { |item_id| sales_engine.items.find_by_id(item_id) }
  end

  def transactions
    sales_engine = @parent.parent
    sales_engine.transactions.find_all_by_invoice_id(id)
  end

  def customer
    sales_engine = @parent.parent
    sales_engine.customers.find_by_id(customer_id)
  end

  def is_paid_in_full?
    sales_engine = @parent.parent
    inv_transactions = sales_engine.transactions.find_all_by_invoice_id(id)
    inv_trx_results = inv_transactions.map { |transaction| transaction.result }
    inv_trx_results.uniq == ["success"]
  end

  def total
    invoices = @parent.parent.invoice_items.all.find_all do |invoice_item|
      invoice_item.invoice_id == @id
    end
    total = invoices.map do |invoice|
      invoice.unit_price * invoice.quantity
    end
    (total.inject(:+)).round(2)
  end

end
