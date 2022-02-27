require 'pry'
require 'csv'
require 'date'
require 'bigdecimal/util'
require_relative 'invoice_item'
require_relative 'sales_module'


class InvoiceItemRepository
  include SalesModule
  attr_reader :all

  def initialize(csv)
    @all = InvoiceItem.read_file(csv)

  end

  def find_all_by_item_id(id)
    @all.find_all{|invoice| invoice.item_id == id}
  end

  def find_all_by_invoice_id(id)
    @all.find_all{|invoice| invoice.invoice_id == id}
  end

  def create(data)
    new_item = InvoiceItem.new({
      id: (@all[-1].id + 1),
      item_id: data[:item_id],
      invoice_id: data[:invoice_id],
      quantity: data[:quantity],
      unit_price: data[:unit_price],
      created_at: Time.now,
      updated_at: Time.now})
      @all << new_item
  end

  def update(id, attribute)
    updated_item = @all.find{|invoice| invoice.id == id}
    updated_item.quantity = attribute[:quantity]
    updated_item.unit_price = attribute[:unit_price]
    updated_item.updated_at = Time.now
  end

end
