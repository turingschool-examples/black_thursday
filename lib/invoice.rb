require 'time'
require 'bigdecimal'

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
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
    @parent      = parent
  end

  def merchant
    @parent.pass_merchant_id_to_se_for_invoice(@merchant_id)
  end

  def items
    @parent.pass_id_to_se_for_item(@id)
  end

  def transactions
    @parent.pass_id_to_se_for_transaction(@id)
  end

  def customer
    @parent.pass_id_to_se_for_customer(@customer_id)
  end
end
