require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(path)
    @invoice_items = []
    load_path(path)
  end

  def all
    @invoice_items
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @invoice_items << InvoiceItem.new(data, self)
    end
  end

  def find_by_id(id)
    @invoice_items.find do |item|
      item.id == id
    end
  end

  def find_all_by_item_id(id)
    @invoice_items.find_all do |item|
      item.item_id == id
    end
  end

  def find_all_by_invoice_id(id)
    @invoice_items.find_all do |item|
      item.invoice_id == id
    end
  end

  def create_new_id
    @invoice_items.map do |item|
      item.id
    end.max + 1
  end

  def create(attributes)
  end

end
