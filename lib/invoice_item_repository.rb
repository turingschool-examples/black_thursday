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
    argument_raiser(id)
    @invoice_items[id]
  end

  def find_all_by_item_id(item_id)
    argument_raiser(item_id)
    all.select do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    argument_raiser(invoice_id)
    all.select do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_all_by_invoice_item_id(id)
    all.select do |invoice_item|
      invoice_item.id == id
    end
  end

  def items(id)
    @parent.items_by_invoice_id(@id)
  end

  def argument_raiser(data_type, desired_class = Integer)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
