require 'bigdecimal'

class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at,
                :repo

  def initialize(invoice_item_info, repo)
    @id = invoice_item_info[:id].to_i
    @item_id = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id].to_i
    @quantity = invoice_item_info[:quantity].to_i
    @unit_price = BigDecimal((invoice_item_info[:unit_price].to_i / 100.to_f), 8)
    @created_at = Time.parse(invoice_item_info[:created_at].to_s)
    @updated_at = Time.parse(invoice_item_info[:updated_at].to_s)
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_id(new_id)
    @id = new_id + 1
  end

  def update_all(atrributes)
    update_quantity(attributes)
    update_unit_price(attributes)
    update_updated_at(attributes)
  end

  def update_quantity(attributes)
    @quantity = attributes[:quantity] if attributes[:quantity]
  end

  def update_unit_price(attributes)
    @unit_price = attributes[:unit_price] if attributes[:unit_price]
  end

  def update_updated_at(attributes)
    @updated_at = attributes[:updated_at] if attributes[:updated_at]
  end

  def update_id(new_id)
    @id = new_id + 1 
  end
end
