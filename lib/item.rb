require 'bigdecimal'
require 'time'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent

  def initialize(information, parent = nil)
    @id = information[:id]
    @name = information[:name]
    @description = information[:description]
    @unit_price = BigDecimal.new(information[:unit_price].to_i/100.0, 4)
    # TODO Check line      ----->>>                           !^^^!
    @created_at = Time.parse(information[:created_at])
    @updated_at = Time.parse(information[:updated_at])
    @merchant_id = information[:merchant_id]
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    sales_engine = @parent.parent
    sales_engine.merchants.find_by_id(@merchant_id)
  end

  def quantity_sold
    sales_engine = @parent.parent
    inv_items = sales_engine.invoice_items.find_all_by_item_id(id)
    inv_items = inv_items.find_all do |inv_item|
      invoice_id = inv_item.invoice_id
      invoice = sales_engine.invoices.find_by_id(invoice_id)
      invoice.is_paid_in_full?
    end
    inv_items.reduce(0) do |total, inv_item|
      total += inv_item.quantity
    end
  end

end
