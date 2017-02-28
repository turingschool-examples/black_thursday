require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_item_data, :all, :parent

  def initialize(invoice_item_data, parent = nil)
    @invoice_item_data = invoice_item_data
    @all = invoice_item_data.map { |row| InvoiceItem.new(row, self) }
    @parent = parent
  end

  def inspect
    @instance.nil? ? nil : "#<#{self.class} #{@instance.size} rows>"
  end

  def find_by_id(id)
    all.find { |invoice_item|  invoice_item.id == id}
  end

  def find_all_by_item_id(item_id)
    all.select { |invoice_item| invoice_item.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.select { |invoice_item| invoice_item.invoice_id == invoice_id}
  end
end
