class Invoice

  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at
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

  def total
    invoice_items.reduce(0) do |sum, paid_invoice|
      sum + (paid_invoice.unit_price * paid_invoice.quantity.to_i)
    end
  end

  def inspect
    "#<#{self.class}"
  end

end
