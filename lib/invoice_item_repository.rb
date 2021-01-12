require_relative 'sales_engine'
require_relative 'invoice_item'
require 'csv'

class InvoiceItemRepository
  attr_reader:path,
             :engine,
             :invoice_items

  def initialize(path, engine)
    @path = path
    @engine = engine
    @invoice_items = []
    read_invoice_items
  end

  def read_invoice_items
    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
    @invoice_items
  end

  def all
    @invoice_items
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def find_by_id(id)
    @invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def highest_id
    @invoice_items.max do |invoice_item|
      invoice_item.id
    end
  end

  def create(attributes)
    attributes[:created_at] = Time.new.to_s
    attributes[:updated_at] = Time.new.to_s
    attributes[:id] = highest_id.id + 1
    @invoice_items << InvoiceItem.new(attributes, self)
  end

  def update(id, attributes)
    update = find_by_id(id)
    return nil if update.nil?
    update.quantity = attributes[:quantity] if attributes.has_key?(:quantity)
    update.unit_price = attributes[:unit_price] if attributes.has_key?(:unit_price)
    update.updated_at = Time.now
  end

  def delete(id)
    delete = find_by_id(id)
    @invoice_items.delete(delete)
  end
end
