require 'csv'
require 'bigdecimal'
require_relative '../lib/invoice_item'
require_relative '../lib/modules/findable'
require_relative '../lib/modules/crudable'

class InvoiceItemRepository
  include Findable
  include Crudable
  attr_reader :all

  def initialize(path)
    @all = []
    create_items(path)
  end

  def create_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      invoice_item = InvoiceItem.new(row)
      @all << invoice_item
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
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

  def find_revenue_by_invoice_id(invoice_id)
    find_all_by_invoice_id(invoice_id).sum do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
  end

  def create(attributes)
    create_new(attributes, InvoiceItem)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    return invoice_item.update(attributes) unless invoice_item.nil?
  end

  def delete(id)
    delete_new(id)
  end
end
