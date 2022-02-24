class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price,
                :created_at, :updated_at

  def initialize(invoice_info)
    @id = invoice_info[:id]
    @item_id = invoice_info[:item_id]
    @invoice_id = invoice_info[:invoice_id]
    @quantity = invoice_info[:quantity]
    @unit_price = invoice_info[:unit_price]
    @created_at = invoice_info[:created_at]
    @updated_at = invoice_info[:updated_at]
  end

end
