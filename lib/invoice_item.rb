class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity,
              :unit_price, :created_at, :updated_at
  def initialize(params, repo=nil)
    @id         = params[:id].to_i
    @item_id    = params[:item_id].to_i
    @quantity   = params[:quantity].to_i
    @invoice_id = params[:invoice_id].to_i
    @price      = BigDecimal.new(params[:unit_price])
    @unit_price = unit_price_to_dollars(@price)
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
  end

  def unit_price_to_dollars(unit_price)
    unit_price / 100
  end
end
