require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item_info, invoice_item_repo)
    @id = invoice_item_info[:id].to_i
    @item_id = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id].to_i
    @quantity = invoice_item_info[:quantity].to_i
    @price = BigDecimal.new(invoice_item_info[:unit_price])
    @unit_price = unit_price_in_dollars(@price)
    @created_at = Time.parse(invoice_item_info[:created_at])
    @updated_at = Time.parse(invoice_item_info[:updated_at])
    @invoice_item_repo = invoice_item_repo
  end

  def unit_price_in_dollars(unit_price)
    unit_price / 100
  end

  def items
    @invoice_item_repo.invoice_items_to_se_item(item_id)
  end

end
