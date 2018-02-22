
#class for invoice items
class InvoiceItemRepository
  attr_reader :parent,
              :invoice_items
  def initialize(filepath, parent)
    @invoice_items = []
    @parent = parent
    load_invoice_items(filepath)
  end

  def load_invoice_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @invoice_items << InvoiceItem.new(data, self)
    end
  end

  def all
    @invoice_items
  end
end
