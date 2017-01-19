require_relative '../lib/invoice_item_repo'
require 'csv'
require 'pry'
require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_reader :parent,
              :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @item_id = data[:item_id].to_i
      @invoice_id = data[:invoice_id].to_i
      @quantity = data[:quantity].to_i
      @unit_price = BigDecimal.new(data[:unit_price].to_i)/BigDecimal.new(100)
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end
  
  def unit_price_to_dollars
    @unit_price.to_f 
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end
end
