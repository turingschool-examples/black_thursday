require_relative 'invoice_repository'

class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at,
                :invoice_parent

  def initialize(invoice_data, parent = nil)
    @invoice_parent = parent
    @id             = invoice_data[:id].to_i
    @customer_id    = invoice_data[:customer_id].to_i
    @merchant_id    = invoice_data[:merchant_id].to_i
    @status         = invoice_data[:status].to_sym
    @created_at  = determine_the_time(invoice_data[:created_at])
    @updated_at  = determine_the_time(invoice_data[:updated_at])
  end

  def merchant
    invoice_parent.parent.merchants.find_by_id(@merchant_id)
  end

  def items
    invoice_parent.parent.invoice_items.find_all_by_invoice_id(id)
  end

  def transactions
    invoice_parent.parent.transactions.find_by_id(id)
  end

  def is_paid_in_full?
    if status != :pending && status != :returned
      true
    else
      false
    end
  end

  def determine_the_time(time_string)
    time = Time.new(0)
    return time if time_string == ""
    time_string = Time.parse(time_string)
  end

end