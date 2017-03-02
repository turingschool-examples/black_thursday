require_relative 'helper'

class Invoice

    attr_reader :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at,
                :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

  def merchant
    parent.find_merchant(merchant_id)
  end

  def weekday_created
    created_at.strftime("%A")
  end

  def items
    parent.find_invoice_items(id)
  end

  def transactions
    parent.find_transactions(id)
  end

  def customer
    parent.find_customer(customer_id)
  end

  def is_paid_in_full?
    parent.check_for_paid_in_full(id) && !transactions.empty?
  end

  def total
    parent.find_invoice_items_total(id)
  end
  
end
