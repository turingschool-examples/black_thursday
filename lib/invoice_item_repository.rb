require_relative 'find_functions'
require_relative 'invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepository

  include FindFunctions

  attr_reader :file_contents,
              :all,
              :parent

  def initialize(file_name = nil, engine = nil)
    return unless file_name
    @parent        = engine
    @file_contents = load(file_name)
    @all           = create_item_objects
  end

  def inspect
    "#<#{self.class}: #{@all.count} rows>"
  end

  def load(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

  def create_item_objects
    @file_contents.map { |row| InvoiceItem.new(row, self) }
  end

  def find_invoice_by_id(id)
    parent.find_invoice_by_id(id)
  end

  def find_item_by_id(item_id)
    parent.find_item_by_id(item_id)
  end

  def find_by_id(id)
    find_by(:id, id)
  end

  def find_all_by_item_id(item_id)
    find_all(:item_id, item_id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all(:invoice_id, invoice_id)
  end

end
