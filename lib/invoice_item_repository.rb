require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :file_path,
              :contents,
              :parent

  def initialize(file_path, parent)
    @file_path = file_path
    @parent    = parent
    @contents  = load_library
  end

  def load_library
    library = {}
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      h = Hash[row]
      d = h[:id]
      library[d.to_i] = InvoiceItem.new(h, self)
    end
    @contents = library
  end

  def all
    contents.map { |k,v| v }
  end

  def find_by_id(id_number)
    contents[id_number]
  end

  def find_all_by_item_id(item_number)
    contents.values.find_all { |v| v.item_id == item_number }
  end

  def find_all_by_invoice_id(invoice_number)
    contents.values.find_all { |v| v.invoice_id == invoice_number }
  end

  def inspect
    "#<#{self.class} #{@contents.size} rows>"
  end
>>>>>>> master
end
