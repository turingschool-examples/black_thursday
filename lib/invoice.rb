
class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status].to_sym
    @created_at  = date_convert(data[:created_at])
    @updated_at  = date_convert(data[:updated_at])
    @parent      = parent
  end

  def date_convert(from_file)
    date = from_file.split("-")
    time = Time.new(date[0], date[1], date[2])
  end

  def merchant
    @parent.parent.merchants.find_by_id(merchant_id)
  end

  def items
    @parent.parent.items.find_all_by_merchant_id(merchant_id)
  end

  def transactions
    @parent.parent.transactions.find_all_by_invoice_id(id)
  end

  def customer
    @parent.parent.customers.find_by_id(customer_id)
  end

  def is_paid_in_full?
    a = @parent.parent.transactions.find_all_by_invoice_id(id)
    b = a.map do |x|
      x.result
    end
    b.include?("failed") ? false : true
  end

  def total
    a = @parent.parent.invoice_items.find_all_by_invoice_id(id)
    b = transactions
    c = a.map do |x|
      b.map do |y|
        if y.result == "success"
          x.unit_price
        end
      end
    end
    c.reduce(:+).compact[0]
  end

end
