require_relative './invoice_item'

class InvoiceItemRepo
  include DataParser
  attr_reader :all

  def initialize(file, parent = nil)
    @all    = parse_data(file).map { |row| InvoiceItem.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    @all.find { |invoice_item| invoice_item.id.eql?(id) }
  end

  def find_all_by_item_id(id)
    @all.find_all { |invoice_item| invoice_item.item_id.eql?(id) }
  end

  def find_all_by_invoice_id(id)
    @all.find_all { |invoice_item| invoice_item.invoice_id.eql?(id) }
  end

  def find_item_by_item_id(id)
    @parent.find_item_by_item_id(id)
  end
end
