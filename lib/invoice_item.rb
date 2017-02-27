require 'bigdecimal'
require 'pry'
require 'time'

class InvoiceItem
  attr_reader :invoice_item_info, :inv_repo_instance
  def initialize(invoice_item_info, inv_item_repo_instance)
    @invoice_item_info = invoice_item_info
    @inv_repo_instance = inv_item_repo_instance
  end

  def id
    invoice_item_hash[:id]
  end

  def item_id
    invoice_item_hash[:item_id]
  end

  def invoice_id
    invoice_item_hash[:invoice_id]
  end

  def quantity
    invoice_item_hash[:quantity]
  end

  def unit_price
    invoice_item_hash[:unit_price]
  end

  def created_at
    invoice_item_hash[:created_at]
  end

  def updated_at
    invoice_item_hash[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f / 100
  end

  def item
    inv_item_repo_instance.sales_engine_instance.items.find_by_id(id)
  end
end