require 'csv'
require 'time'


class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :engine, :created_at, :updated_at

  def initialize(invoice_item_info, engine)
    @id = invoice_item_info[:id].to_i
    @item_id = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id].to_i
    @created_at = Time.parse(invoice_item_info[:created_at])
    @updated_at = Time.parse(invoice_item_info[:updated_at])
    @quantity = invoice_item_info[:quantity].to_i
    @unit_price = invoice_item_info[:unit_price]
    @engine = engine
  end

end
