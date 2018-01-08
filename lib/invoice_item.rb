require 'bigdecimal'
require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(info, invoice_item_repository = "")
    @id         = info[:id].to_i
    @item_id    = info[:item_id].to_i
    @invoice_id = info[:invoice_id].to_i
    @quantity   = info[:quantity].to_i
    @unit_price = BigDecimal.new((info[:unit_price].to_i)/100.0, 5)
    @created_at = Time.strptime(info[:created_at],time_analyzer(info[:created_at]))
    @updated_at = Time.strptime(info[:updated_at],time_analyzer(info[:updated_at]))
    @parent     = invoice_item_repository
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def items
    @parent.items_by_invoice_id(@id)
  end

  def invoice_items_by_date
    @parent.invoice_items_by_date(@created_at)
  end

  def time_analyzer(info)
    if info.length > 10
      "%Y-%m-%d %H:%M:%S %Z"
    else
      "%Y-%m-%d"
    end
  end
end
