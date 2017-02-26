require 'bigdecimal'

class InvoiceItem
  attr_reader :invoice_item_hash, :repository

  def initialize(hash, repository = '')
    @invoice_item_hash = hash
    @repository = repository
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
    repository.engine.items.find_by_id(item_id)
  end
end
