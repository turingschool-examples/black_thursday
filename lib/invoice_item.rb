require_relative './time_store_module'
require 'bigdecimal'

class InvoiceItem
  include TimeStoreable

  attr_accessor :unit_price,
                :updated_at,
                :quantity

  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at,
              :repository

  def initialize(data, repository)
    @id         = data[:id].to_i
    @item_id    = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity   = data[:quantity].to_i
    @unit_price = BigDecimal(data[:unit_price])/100
    @created_at = time_store(data[:created_at])
    @updated_at = time_store(data[:updated_at])
    @repository = repository
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
