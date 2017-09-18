require 'bigdecimal'

require_relative 'repository/record'


class InvoiceItem < Repository::Record

  attr_reader :item_id, :invoice_id, :quantity, :unit_price
  def initialize(repo, fields)
    super(repo, fields)
    @item_id =    fields[:item_id].to_i
    @invoice_id = fields[:invoice_id].to_i
    @quantity =   fields[:quantity].to_i
    @unit_price = BigDecimal.new(fields[:unit_price]) / 100
  end

  def item
    repo.parent(:items, item_id)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
