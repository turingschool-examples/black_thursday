class InvoiceItem
  attr_reader :parent,
              :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @parent      = parent
    @id          = data[:id].to_i
    @item_id     = data[:item_id].to_i
    @invoice_id  = data[:invoice_id].to_i
    @quantity    = data[:quantity].to_i
    @unit_price  = data[:unit_price].to_i
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
  end

  # def merchant
  #   payload = ['invoices merchant', merchant_id]
  #   current_location = self
  #   while current_location.respond_to?('parent')
  #     current_location = current_location.parent
  #   end
  #   current_location.route(payload)
  # end
end
