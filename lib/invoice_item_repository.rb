require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository
  include Repository

  def initialize
    @invoice_items = []
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

  def all
    @invoice_items
  end

  def create_with_id(attributes)
    @invoice_items << InvoiceItem.new(attributes)
  end

  def child_class
    InvoiceItem
  end

  def create(attributes)
    all << child_class.create(attributes)
  end

  def find_all_by_item_id(item_id)
    all.find_all do |item|
      item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |item|
      item.invoice_id == invoice_id
    end
  end

  def update(id, attributes)
    item = find_by_id(id)
    return nil if item.nil?
    item.quantity = attributes[:quantity] unless attributes[:quantity].nil?
    item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    item.updated_at = Time.now
  end
  
  def group_by_day
    @invoice_items.group_by do |invoice|
      binding.pry
      invoice.created_at
    end
  end
end
