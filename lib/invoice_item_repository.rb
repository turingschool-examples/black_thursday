require_relative 'invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def from_csv(file_path)
    CSV.foreach(file_path, headers: true, :header_converters => :symbol) do |row|
      @all << InvoiceItem.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

end
