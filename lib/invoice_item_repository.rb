require 'csv'
require 'bigdecimal'
require_relative '../lib/invoice_item'

class InvoiceItemRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_items(path)
  end

  def create_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      invoice_item = InvoiceItem.new(row)
      @all << invoice_item
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def find_by_id(id)
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    new_id = @all.max_by do |invoice_item|
      invoice_item.id
    end

    attributes[:id] = new_id.id + 1

    invoice_item = InvoiceItem.new(attributes)
    @all << invoice_item
    invoice_item
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    return invoice_item.update(attributes) unless invoice_item.nil?
  end

  def delete(id)
    delete_item = find_by_id(id)
    @all.delete(delete_item)
  end
end
