require 'bigdecimal'
require 'time'

class InvoiceItem
  def initialize(sales_engine, invoice_item_info_hash)
    @sales_engine = sales_engine
    @id = invoice_item_info_hash[:id]
    @item_id = invoice_item_info_hash[:item_id]
    @invoice_id = invoice_item_info_hash[:invoice_id]
    @quantity = invoice_item_info_hash[:quantity]
    @unit_price = invoice_item_info_hash[:unit_price]
    @created_at = invoice_item_info_hash[:created_at]
    @updated_at = invoice_item_info_hash[:updated_at]
  end

  def id
    @id.to_i
  end

  def item_id
    @item_id.to_i
  end

  def invoice_id
    @invoice_id.to_i
  end

  def quantity
    @quantity.to_i
  end

  def unit_price
    BigDecimal.new(@unit_price)/100.round(2)
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def unit_price_to_dollars
    unit_price/100.to_f.round(2)
  end

  def inspect
    "id: #{id}"
  end

end
