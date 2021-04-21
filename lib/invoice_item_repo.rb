require 'CSV'
require 'bigdecimal'
require 'invoice_item'
require_relative 'findable'
include Findable

class InvoiceItemRepo
  attr_reader :invoice_items,
              :engine

  def initialize(path, engine)
    @invoice_items = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @invoice_items << InvoiceItem.new(row, self)
    end
  end

  def all
    @invoice_items
  end
end
