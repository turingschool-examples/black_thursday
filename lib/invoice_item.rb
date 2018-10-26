class InvoiceItem

  attr_reader :id

  def initialize(invoice_item_data)
    @id = invoice_item_data[:id].to_i

  end
end
