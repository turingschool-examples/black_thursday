require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(path, sales_engine = "")
    @invoice_items = {}
    @parent        = sales_engine
    invoice_item_creator_and_storer(path)
  end

  def invoice_item_creator_and_storer(path)
    csv_opener(path).each do |invoice_item|
      new_invoice_item = InvoiceItem.new(invoice_item, self)
      @invoice_items[new_invoice_item.id] = new_invoice_item
    end
  end

  def csv_opener(path = "./data/invoice_items.csv")
    CSV.open path, headers: true, header_converters: :symbol
  end

  def all
    @invoice_items.values
  end

  def find_by_id(id)
    argument_raiser(id, Integer)
    @invoice_items[id]
  end

  def find_all_by_item_id(id)
    argument_raiser(id, Integer)
    @invoice_items.select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    argument_raiser(id, Integer)
    @invoice_items.select do |invoice_item|
      invoice_item.invoice_id == id
    end
  end

  def argument_raiser(data_type, desired_class = String)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
