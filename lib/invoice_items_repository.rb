require 'csv'
require './lib/invoice_items'
require './lib/repository_aide'

class InvoiceItemsRepository
  include RepositoryAide
  attr_reader :repository

  def initialize(file)
    @invoice_items = CSV.read(file, headers: true, header_converters: :symbol)
    @repository = @invoice_items.map do |invoice_item|
                  InvoiceItems.new({:id => invoice_item[:id],
                                    :item_id => invoice_item[:item_id],
                                    :invoice_id => invoice_item[:invoice_id],
                                    :quantity => invoice_item[:quantity],
                                    :unit_price => invoice_item[:unit_price],
                                    :created_at => invoice_item[:created_at],
                                    :updated_at => invoice_item[:updated_at]})
                                  end
  end

  def find_all_by_item_id(item_id)
    @repository.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @repository.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    InvoiceItems.new({id: new_id.to_s,
                      item_id: attributes[:item_id],
                      invoice_id: attributes[:invoice_id],
                      quantity: attributes[:quantity],
                      unit_price: attributes[:unit_price],
                      created_at: attributes[:created_at],
                      updated_at: attributes[:updated_at]})
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    invoice_item.quantity = attributes[:quantity]
    invoice_item.unit_price = attributes[:unit_price]
    invoice_item.updated_at = Time.now
  end
end
