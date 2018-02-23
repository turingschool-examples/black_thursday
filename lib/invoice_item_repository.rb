
require_relative '../lib/invoice_item'
# class for invoice items
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

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def find_by_id(id)
    @invoice_items.find { |invoice| invoice.id == id }
  end

  def find_all_by_item_id(id)
    @invoice_items.find_all do |invoice|
      invoice.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @invoice_items.find_all do |invoice|
      invoice.invoice_id == id
    end
  end
end
