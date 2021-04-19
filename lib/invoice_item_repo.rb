require_relative './invoice_items'
require 'time'
require 'csv'
require 'bigdecimal'

class InvoiceItemRepo

  attr_reader :invoice_item_list

  def initialize(csv_files, engine)
    @invoice_item_list = invoice_item_instances(csv_files)
    @engine = engine
  end

  def invoice_item_instances(csv_files)
    invoice_items = CSV.open(csv_files, headers: true,
    header_converters: :symbol)

    @invoice_items_list = invoice_items.map do |invoice_item|
      Invoice.new(invoice_item, self)
    end
  end

  def all
    @invoice_item_list
  end 
end
