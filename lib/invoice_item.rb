require_relative './enumerable'

class InvoiceItem
  include Enumerable
  attr_reader :id, :item_id, :invoice_id, :created_at
  attr_accessor :quantity, :unit_price, :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end
end
