require './lib/invoice_item'
class InvoiceItemRepository
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @invoice_items = []
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find do |ii|
      ii.id == id
    end
  end

  def add_data(data)
    @invoice_items << InvoiceItem.new(data.to_hash, @sales_engine)
  end


  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
