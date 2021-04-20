require 'CSV'
require 'bigdecimal'
require 'invoice_item'

class InvoiceItemRepo
  attr_reader :invoice_items

  def initialize(path, engine)
    @invoice_items = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)

    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @invoice_items << InvoiceItem.new(data)
    end
  end

  def all
    @invoice_items
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end


end

def find_by_id(id)
  @invoice_items.find do |invoice_item|
    invoice_item.id == id
  end
end

def create(attributes)
  invoice_item = InvoiceItem.new(attributes)
  max = @invoice_items.max_by do |invoice_item|
    invoice_item.id
  end
  invoice_item.id = max.id + 1
  add_invoice_item(invoice_item)
  invoice_item
end
