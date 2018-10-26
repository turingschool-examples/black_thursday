class InvoiceItem

  attr_reader :id, :item_id

  def initialize(invoice_item_data)
    @id = invoice_item_data[:id].to_i
    @item_id = invoice_item_data[:item_id].to_i
  end
end
