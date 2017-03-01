require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'item'
require_relative 'csv_parser'
require_relative 'merchant'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'customer'
require_relative 'customer_repository'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = data[:unit_price] # bigdecimal
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

  def unit_price_to_dollars
    # repeated method, consider moving to module
    unit_price.to_f  
  end

  
end