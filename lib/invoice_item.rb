require 'bigdecimal'
require 'time'

class InvoiceItem
  attr_reader :repo
  attr_accessor :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at

  def initialize(invoice_item_hash, repo)
    @id = invoice_item_hash[:id].to_i
    @item_id = invoice_item_hash[:item_id]
    @invoice_id = invoice_item_hash[:invoice_id]
    @quantity = BigDecimal(invoice_item_hash[:quantity]) / 100
    @unit_price = BigDecimal(invoice_item_hash[:unit_price]) / 100
    @created_at = Time.parse(invoice_item_hash[:created_at].to_s)
    @updated_at = Time.parse(invoice_item_hash[:updated_at].to_s)
    @repo = repo
  end

  def to_hash
    self_hash = Hash.new
    self_hash[:id] = @id
    self_hash[:item_id] = @item_id
    self_hash[:invoice_id] = @invoice_id
    self_hash[:quantity] = @quantity
    self_hash[:unit_price] = @unit_price
    self_hash[:created_at] = @created_at
    self_hash[:updated_at] = @updated_at
    self_hash
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
  # on refactor could be placed in helper methods. in item class i believe.

end
