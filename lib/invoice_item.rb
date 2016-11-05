require 'csv'
require './lib/invoice_item_repo'
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
      @customer_id = data[:customer_id]
      @merchant_id = data[:merchant_id]
      @status = data[:status]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f #BigDecimal??
    #returns the price of the invoice item in dollars formatted as a Float
  end

end
