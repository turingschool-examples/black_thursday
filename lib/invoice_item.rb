require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price,
              :created_at, :updated_at, :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price].to_i)/BigDecimal.new(100)
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def items

  end

  def is_paid_in_full?

  end

  def total

  end


end
