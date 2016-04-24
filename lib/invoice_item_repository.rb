require_relative 'invoice_item'
require_relative 'csv_io'
require_relative 'find'

class InvoiceItemRepository
  include Find
  include CSV_IO

  attr_accessor :invoice_items
  attr_reader :file, :sales_engine

  def initialize(file=nil, sales_engine)
    @file = file
    @invoice_items = []
    @sales_engine = sales_engine
  end

  def add_new(data, sales_engine)
    invoice_items << InvoiceItem.new(data, sales_engine)
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    find_by_num({:id => id})
  end

  def find_all_by_item_id(item_id)
    find_all_by_num({:item_id => item_id})
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by_num({:invoice_id => invoice_id})
  end

end
