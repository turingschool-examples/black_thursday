class InvoiceItem
  attr_reader :id, :item_id, :invoice_id

  def initialize(data)
    @id = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
  end

end
