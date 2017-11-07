class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price,
              :created_at, :updated_at, :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price])/100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @repository = repository
  end

end
