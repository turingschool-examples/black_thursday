require_relative '../lib/invoice_item_repository'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'

class InvoiceItem
  attr_reader :invoice_item_repo,
              :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item_data, invoice_item_repo)
    @invoice_item_repo = invoice_item_repo
    @id = invoice_item_data[:id].to_i
    @item_id = invoice_item_data[:item_id].to_i
    @invoice_id = invoice_item_data[:invoice_id].to_i
    @quantity = invoice_item_data[:quantity].to_i
    @unit_price = ((invoice_item_data[:unit_price].to_f)/ 100).to_d
    @created_at = Time.parse(invoice_item_data[:created_at].to_s)
    @updated_at = Time.parse(invoice_item_data[:updated_at].to_s)
  end
end
