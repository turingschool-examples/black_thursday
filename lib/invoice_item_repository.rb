require_relative 'sales_engine'
require_relative 'invoice_item'
require_relative 'mathable'

class InvoiceItemRepository
  include Mathable
  attr_reader :invoice_items

  def initialize(path, engine)
    @invoice_items = []
    @engine = engine
    make_invoice_items(path)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def make_invoice_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
  end

  def all
    @invoice_items
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

  def generate_new_id
    highest_id_invoice_item = @invoice_items.max_by do |invoice_item|
      invoice_item.id
    end
    highest_id_invoice_item.id + 1
  end

  def create(attributes)
    attributes[:id] = generate_new_id
    @invoice_items << InvoiceItem.new(attributes, self)
  end

  def update(id, attributes)
    return nil if find_by_id(id) == nil
    invoice_item_to_update = find_by_id(id)
    invoice_item_to_update.update(attributes)
  end

  def delete(id)
    invoice_items.delete(find_by_id(id))
  end

  def invoice_total(invoice_id)
    @invoice_items.each_with_object([]) do |invoice_item, array|
      if invoice_item.invoice_id == invoice_id
        array << invoice_item.quantity * invoice_item.unit_price
      end
    end.sum
  end
end
