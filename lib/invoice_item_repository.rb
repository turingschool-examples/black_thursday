# frozen_string_literal: true

require_relative 'invoice_item.rb'
require_relative 'repository_helper.rb'
# This class holds how invoices are connected to items
class InvoiceItemRepository
  include RepositoryHelper
  attr_reader :repository,
              :parent

  def initialize(invoice_items, parent)
    @repository = invoice_items.map do |invoice_item|
      InvoiceItem.new(invoice_item, self)
    end
    @parent = parent
    build_hash_tables
  end

  def build_hash_tables
    @id = @repository.group_by(&:id)
    @item_id = @repository.group_by(&:item_id)
    @invoice_id = @repository.group_by(&:invoice_id)
    @quantity = @repository.group_by(&:quantity)
    @unit_price = @repository.group_by(&:unit_price)
    @created_at = @repository.group_by(&:created_at)
    @updated_at = @repository.group_by(&:updated_at)
  end

  def find_all_by_item_id(item_id)
    @item_id[item_id]
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_id[invoice_id]
  end

  def create(attributes)
    attributes[:id] = (@id.keys.last + 1)
    @repository << InvoiceItem.new(attributes, self)
    build_hash_tables
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    unchangeable_keys = %i[id item_id created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if invoice_item.invoice_items_specs.keys.include?(key)
        invoice_item.invoice_items_specs[key] = value
        invoice_item.invoice_items_specs[:updated_at] = Time.now
      end
    end
    build_hash_tables
  end

  def group_by_number_of_items
    @repository.map do |invoice_item|
      [invoice_item.invoice_id, invoice_item.quantity]
    end
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @repository.delete(item_to_delete)
    build_hash_tables
  end

  def inspect
    "<#{self.class} #{@repository.size} rows>"
  end
end
