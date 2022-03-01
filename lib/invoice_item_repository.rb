# require 'CSV'
require 'pry'
require_relative './sales_engine.rb'
require_relative './findable.rb'
require_relative './invoice_item.rb'
require_relative './crudable.rb'
require 'BigDecimal'
require 'Time'
# require 'simplecov'
# SimpleCov.start

class InvoiceItemRepository
  include Findable
  include Crudable
  attr_reader :all
  attr_accessor :new_object

  def initialize(irr_array)
    @all = irr_array
    @new_object = InvoiceItem
  end

  def find_all_by_item_id(id)
    all.find_all { |invoice| id == invoice.item_id }
  end

  def invoice_items_by_invoice_id
    @by_invoice ||= all.group_by { |invoice_item| invoice_item.invoice_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items_by_invoice_id[invoice_id] || []
  end

  # def sum_invoice_items(invoice_id)
  #   find_all_by_invoice_id(invoice_id).sum do |invoice_item|
  #     invoice_item.unit_price * invoice_item.quantity
  #   end
  # end

  def inspect
  end
end
