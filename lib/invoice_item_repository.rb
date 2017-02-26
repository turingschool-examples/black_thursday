require 'csv'
require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository

  attr_reader :klass, :data

  def initialize(sales_engine, path)
    super(sales_engine, path, InvoiceItem)
  end

  def all
    data
  end

  def find_by_id(id)
    data.select { |invoice_item| invoice_item.id == id }.first
  end

  def find_all_by_item_id(item_id)
    data.select { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    data.select { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

end
