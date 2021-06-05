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

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_all_by_item_id(id)
    @all.find_all do |item|
      item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @all.find_all do |item|
      item.invoice_id == id
    end
  end

  def new_id_number
    invoice_item = @all.max_by { |item| item.id }
    invoice_item.id + 1
  end
end
