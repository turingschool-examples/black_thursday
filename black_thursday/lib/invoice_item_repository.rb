require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(csv_file, parent = nil)
    @invoice_items = load_csv(csv_file).map {|row| InvoiceItem.new(row, self)}
    @parent        = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    return [] if item_id.nil?
    invoice_items.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    return [] if invoice_id.nil?
    invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def inspect
    "#{self.class} has #{all.count} rows"
  end
end
