require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_invoice_items(path)
  end

  def create_invoice_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol).each do |invoice_item|
      @all << InvoiceItem.new(invoice_item, self)
    end
  end
end
