class InvoiceItem
  attr_accessor :quantity, :unit_price, :updated_at
  attr_reader :id, :item_id, :invoice_id, :created_at 
  def initialize(stats)
    @id = stats[:id].to_i
    @item_id = stats[:item_id].to_i
    @invoice_id = stats[:invoice_id].to_i
    @quantity = stats[:quantity].to_i
    @unit_price = convert(stats[:unit_price])
    @created_at = Time.parse(stats[:created_at].to_s)
    @updated_at = Time.parse(stats[:updated_at].to_s)
  end
end

def convert(arg)
  if arg.class != BigDecimal
    converted = arg.to_f / 100
    length = arg.to_s.length
    conversion = BigDecimal.new(converted, length)
    conversion
  else
    arg
  end
end
