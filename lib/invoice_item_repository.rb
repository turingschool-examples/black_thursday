require './lib/invoice_item'
require 'csv'

class InvoiceItemRepository
  attr_reader :all,
              :parent

  def initialize(file_path, parent = nil)
    @all = from_csv(file_path).map { |row| InvoiceItem.new(row, self) }
    @parent = parent
  end

  def from_csv(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

  def find_by_id(id)
    all.find { |invoice_item| invoice_item.id == id.to_i }
  end

  def find_all_by_item_id(item_id)
    all.select { |invoice_item| invoice_item.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.select { |invoice_item| invoice_item.invoice_id == invoice_id}
  end
end
