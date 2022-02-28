require 'csv'
require './lib/invoice_items'
require './lib/repository_aide'

class InvoiceItemsRepository
  include RepositoryAide
  attr_reader :repository

  def initialize(file)
    @repository = read_csv(file).map do |invoice_item|
                  InvoiceItems.new({
                    :id => invoice_item[:id].to_i,
                    :item_id => invoice_item[:item_id],
                    :invoice_id => invoice_item[:invoice_id],
                    :quantity => invoice_item[:quantity].to_i,
                    :unit_price => invoice_item[:unit_price],
                    :created_at => invoice_item[:created_at],
                    :updated_at => invoice_item[:updated_at]})
                                  end
    group_hash
  end

  def group_hash
    @item_ids = @repository.group_by {|invoice_item| invoice_item.item_id}
    @invoice_ids = @repository.group_by {|invoice_item| invoice_item.invoice_id}
  end

  def find_all_by_item_id(item_id)
    find(@item_ids, item_id)
  end

  def find_all_by_invoice_id(invoice_id)
    find(@invoice_ids, invoice_id)
  end

  def create(attributes)
    invoice_item = InvoiceItems.new(create_attribute_hash(attributes))
    @repository << invoice_item
    invoice_item
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    invoice_item.quantity = attributes[:quantity]
    invoice_item.unit_price = attributes[:unit_price]
    invoice_item.updated_at = Time.now
  end
end
