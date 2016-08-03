require "bigdecimal"

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at,
              :updated_at


  def initialize(data, parent = nil)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price]) / 100
    @created_at = time_formatter(data[:created_at])
    @updated_at = time_formatter(data[:updated_at])
    @parent = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def time_formatter(date_time)
    if date_time.include?(":")
      Time.strptime(date_time, "%Y-%m-%d %H:%M:%S %z")
    else
      Time.strptime(date_time, "%Y-%m-%d")
    end
  end

  def item
    @parent.find_item_by_id(self.item_id)
  end
end
