class InvoiceItem
  attr_reader :id,
            :item_id,
            :invoice_id,
            :quantity,
            :unit_price,
            :created_at,
            :updated_at,
            :parent

  def initialize(args, parent)
    @args        = args
    @id          = args[:id]
    @item_id     = args[:item_id]
    @invoice_id  = args[:invoice_id]
    @quantity    = args[:quantity]
    @unit_price  = (args[:unit_price].to_d) / 100
    @created_at  = Time.parse(args[:created_at].to_s)
    @updated_at  = Time.parse(args[:updated_at].to_s)
    @parent      = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
