require 'bigdecimal'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id         = data[:id].to_i
    @item_id    = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity   = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price].insert(-3, "."), 4)
    @created_at = date_convert(data[:created_at])
    @updated_at = date_convert(data[:updated_at])
    @parent     = parent
  end

  def date_convert(from_file)
    date = from_file.split(/[-," ",:]/)
    time = Time.utc(date[0], date[1], date[2], date[3], date[4], date[5], date[6], date[7])
  end

  def unit_price_to_dollars(id)
    parent.contents[id].unit_price.to_f
  end
end
