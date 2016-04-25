class Invoice

  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at,
                :total
  attr_accessor :merchant,
                :items,
                :invoice_items,
                :transactions,
                :customer

  def initialize(invoice_data)
    @id = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status = invoice_data[:status].to_sym
    @created_at = Time.parse(invoice_data[:created_at])
    @updated_at = Time.parse(invoice_data[:updated_at])
  end

  def is_paid_in_full?
    transactions.any? { |transaction| transaction.result == "success" }
  end

  def paid_total
    if is_paid_in_full?
      total
    else
      0
    end
  end

  def total
    invoice_items.reduce(0) do |sum, item_total|
      sum + (item_total.unit_price * item_total.quantity.to_i)
    end
  end

  def inspect
    "#<#{self.class}"
  end

end
