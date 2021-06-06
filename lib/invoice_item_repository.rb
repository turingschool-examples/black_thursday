require 'CSV'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :id, :item_id, :all, :invoice_items, :file_path, :engine

  def initialize(file_path, engine)
    @file_path = file_path
    @engine = engine
    @invoice_items = []
  end

  def create_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      invoice_item = InvoiceItem.new(row, self)
      @invoice_items << invoice_item
    end
    self
  end

  def all
    invoice_items
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def find_by_id(id)
    invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    items.find_all do |item|
      item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    items.find_all do |item|
      item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    invoice_item_id = invoice_items.max { |invoice_item| invoice_item.id}
    attributes[:id] = invoice_item_id.id + 1
    attributes[:created_at] = Time.now.strftime("%Y-%m-%d")
    attributes[:updated_at] = Time.now.strftime("%Y-%m-%d")
    @invoice_items << InvoiceItem.new(attributes, self)
  end

  def update(id, attributes)
  invoice_item_by_id = find_by_id(id)
    if invoice_item_by_id != nil
      invoice_item_by_id.change_quantity(attributes[:quantity])
      invoice_item_by_id.change_unit_price(attributes[:unit_price])
      invoice_item_id.update_time
    end
  end

  def delete(id)
    chopping_block = invoice_items.index { |invoice_item| invoice_item.id == id }
    if chopping_block != nil
      invoice_items.delete_at(chopping_block)
    end
  end

end
