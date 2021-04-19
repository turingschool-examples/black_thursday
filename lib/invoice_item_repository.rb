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

  def create(attributes)
    attributes[:id] = RepoBrain.generate_new_id(@invoice_items)
    @invoice_items << InvoiceItem.new(attributes, self)
  end

  def delete(id)
    invoice_items.delete(find_by_id(id))
  end

  def find_all_by_item_id(item_id)
    RepoBrain.find_all_by_id(item_id, 'item_id', @invoice_items)
  end

  def find_all_by_invoice_id(invoice_id)
    RepoBrain.find_all_by_id(invoice_id, 'invoice_id', @invoice_items)
  end

  def find_by_id(id)
    RepoBrain.find_by_id(id, 'id', @invoice_items)
  end

  def invoice_total(invoice_id)
    @invoice_items.each_with_object([]) do |invoice_item, array|
      if invoice_item.invoice_id == invoice_id
        array << invoice_item.quantity * invoice_item.unit_price
      end
    end.sum
  end

  def invoice_total_hash
    @invoice_items.each_with_object(Hash.new(0)) do |invoice_item, hash|
      if @engine.invoice_paid_in_full?(invoice_item.invoice_id)
        hash[invoice_item.invoice_id] += invoice_item.quantity * invoice_item.unit_price
      end
    end
  end

  def update(id, attributes)
    return nil if find_by_id(id) == nil
    invoice_item_to_update = find_by_id(id)
    invoice_item_to_update.update(attributes)
  end
end
