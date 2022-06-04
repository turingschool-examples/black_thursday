class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity

  def initialize(data)
    @id = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
  end

end
