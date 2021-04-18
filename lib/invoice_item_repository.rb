require 'bigdecimal'
require 'CSV'
require 'time'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(path, engine)
    @invoice_items = []
    populate_information(path)
  end


  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |item_info|
      @invoice_items << InvoiceItem.new(item_info)
    end
  end

  def all
    @invoice_items
  end
end
