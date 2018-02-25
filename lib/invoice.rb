require 'time'
require 'bigdecimal'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent,
              :quantity

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

  def invoice_items
    @parent.pass_id_to_se_for_item(@id)
  end

  def items
    item_ids = invoice_items.map do |invoice_item|
      invoice_item.item_id
    end
    item_ids.map do |item_id|
      @parent.pass_item_id_to_se(item_id)
    end
  end

  def transactions
    @parent.pass_id_to_se_for_transaction(@id)
  end

  def is_paid_in_full?
    pass = transactions.map(&:result)
      if transactions.empty?
        false
      elsif pass.all? {|result| result == "failed"}
        false
      else
        true
      end
  end

  def total
    invoice_items.reduce(0) do |total, invoice_item|
      total + invoice_item.quantity.to_f * invoice_item.unit_price.to_f
    end.round(2)
  end

  def quantity
  @quantity = invoice_items.map do |invoice_item|
      invoice_item.quantity.to_i
    end.sum
  end

  def customer
    @parent.pass_id_to_se_for_customer(@customer_id)
  end
end
