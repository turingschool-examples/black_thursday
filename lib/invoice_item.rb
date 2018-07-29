require 'bigdecimal'
require 'time'
class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  @@highest_item_id = 0

  def initialize(attributes)
    @id = attributes[:id].to_i
    @item_id = attributes[:item_id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @quantity = attributes[:quantity]
    @unit_price = BigDecimal(attributes[:unit_price]) / 100
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    highest_id_updater
  end

  def highest_id_updater
    @@highest_item_id = @id if @id > @@highest_item_id
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def self.create(attributes)
    item_id = @@highest_item_id += 1
    new(id: item_id,
        item_id: attributes[:item_id],
        invoice_id: attributes[:invoice_id],
        quantity: attributes[:quantity],
        unit_price: attributes[:unit_price],
        created_at: attributes[:created_at].to_s,
        updated_at: attributes[:updated_at].to_s)
  end

end
