require_relative '../lib/invoice_item_repo'
require 'csv'
require 'pry'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @item_id = data[:item_id]
      @invoice_id = data[:invoice_id]
      @quantity = data[:quantity]
      @unit_price = data[:unit_price]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end
  
  def unit_price_to_dollars
    @unit_price.to_f #BigDecimal??
    #returns the price of the invoice item in dollars formatted as a Float
  end
end
