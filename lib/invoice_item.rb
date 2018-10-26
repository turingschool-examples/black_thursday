class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity

  def initialize(invoice_item_data)
    @id = invoice_item_data[:id].to_i
    @item_id = invoice_item_data[:item_id].to_i
    @invoice_id = invoice_item_data[:invoice_id].to_i
    @quantity = invoice_item_data[:quantity].to_i
  end
end
