require 'bigdecimal'
require 'time'

class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at,
                :invoice_item_repo

  attr_accessor :status,
                :updated_at

  def initialize(row, invoice_repo)
    @id = (row[:id]).to_i
    @item_id = row[:item_id].to_i
    @invoice_id = (row[:invoice_id]).to_i
    @quantity = (row[:quantity]).to_i
    @unit_price = (row[:unit_price]).to_i
    @created_at = Time.parse(row[:created_at].to_s)
    @updated_at = Time.parse(row[:updated_at].to_s)
    @invoice_item_repo = invoice_item_repo
  end
end
