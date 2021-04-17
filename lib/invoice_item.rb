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
    @unit_price = BigDecimal(row[:unit_price]) / 100
    @created_at = Time.parse(row[:created_at].to_s)
    @updated_at = Time.parse(row[:updated_at].to_s)
    @invoice_item_repo = invoice_item_repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update(attributes)
    update_quantity(attributes)
    update_unit_price(attributes)
    update_time_stamp
  end

  def update_quantity(attributes)
    if attributes[:quantity] != nil
      @quantity = attributes[:quantity].to_i
    end
  end

  def update_unit_price(attributes)
    if attributes[:unit_price] != nil
      @unit_price = BigDecimal(attributes[:unit_price])
    end
  end

  def update_time_stamp
    @updated_at = Time.now
  end
end
