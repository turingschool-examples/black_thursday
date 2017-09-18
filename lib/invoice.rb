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
