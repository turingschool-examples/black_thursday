require 'bigdecimal'
require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(info, invoice_repository = "")
    @id = info[:id].to_i
    @customer_id = info[:customer_id].to_i
    @merchant_id = info[:merchant_id].to_i
    @status = :"#{info[:status]}"
    @created_at = Time.strptime(info[:created_at], "%Y-%m-%d")
    @updated_at = Time.strptime(info[:updated_at], "%Y-%m-%d")
    @parent = invoice_repository
  end

  def merchant
    @parent.merchant(@merchant_id)
  end

  def items
    @parent.invoice_items(@id)
  end
end
