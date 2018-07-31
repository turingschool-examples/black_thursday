require_relative '../lib/invoice_item.rb'
require_relative'../lib/repository_helper.rb'
require_relative'../lib/sales_engine.rb'

require 'csv'
class InvoiceItemRepository
  include RepositoryHelper
  attr_reader :all,
              :invoice_items
  def initialize(filepath)
    @filepath = filepath
    @invoice_items = []
    @all = []
  end

  def create_invoice_items
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << InvoiceItem.new(row)
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def create(attributes)
    id = create_id
    invoice_item = InvoiceItem.new(
      id: id,
      item_id: attributes[:item_id],
      invoice_id: attributes[:invoice_id],
      quantity: attributes[:quantity],
      unit_price: attributes[:unit_price],
      created_at: Time.now,
      updated_at: Time.now
      )
    @all << invoice_item
    invoice_item
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return if invoice.nil?
    invoice.quantity = attributes[:quantity] || invoice.quantity
    invoice.unit_price = attributes[:unit_price] || invoice.unit_price
    invoice.updated_at = Time.now
    invoice
  end
end
