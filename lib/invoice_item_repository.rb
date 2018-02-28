require_relative 'searching'
require_relative 'invoice_item'

# relates invoices to items
class InvoiceItemRepository
  include Searching
  attr_reader :all

  def initialize(file_path, sales_eng)
    @all       = from_csv(file_path)
    @sales_eng = sales_eng
  end

  def add_elements(data)
    data.map { |row| InvoiceItem.new(row, self) }
  end

  def find_all_by_item_id(id)
    @all.find_all { |obj| obj.item_id == id }
  end

  def find_all_by_invoice_id(id)
    @all.find_all { |obj| obj.invoice_id == id }
  end

  def inspect
    "#<#{self.class} #{@all.length} rows>"
  end
end
