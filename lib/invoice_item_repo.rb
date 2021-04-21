require 'CSV'
require 'bigdecimal'
require 'invoice_item'
require_relative 'findable'
include Findable

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

  def add_invoice_item(invoice_item)
    @invoice_items << invoice_item
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


  def find_all_by_invoice_id(id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

# find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
end
