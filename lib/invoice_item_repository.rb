require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :all

  def initialize(file_path, parent = nil)
    @parent = parent
    @all = []
    populate_invoices(file_path)
  end

  def populate_invoices(file_path)
    CSV.foreach(file_path, row_sep: :auto, headers: true) do |line|
      self.all << InvoiceItem.new(line, self)
    end
  end

  def find_by_id(id)
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

end
