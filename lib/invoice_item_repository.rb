# frozen_string_literal: true

require_relative 'invoice_item.rb'

# This class holds how invoices are connected to items
class InvoiceItemRepository
  attr_reader :repository,
              :parent

  def initialize(invoice_items, parent)
    @repository = invoice_items.map do |invoice_item|
      InvoiceItem.new(invoice_item, self)
    end
    @parent = parent
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    @repository.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @repository.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def create(attributes)
    id_array = @repository.map(&:id)
    new_id = id_array.max + 1
    attributes[:id] = new_id.to_s
    @repository << InvoiceItem.new(attributes, self)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    unchangeable_keys = [:id, :item_id, :created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if invoice_item.invoice_items_specs.keys.include?(key)
        invoice_item.invoice_items_specs[key] = value
        invoice_item.invoice_items_specs[:updated_at] = Time.now
      end
    end
  end

  def group_by_number_of_items
    @repository.map do |invoice_item|
      [invoice_item.invoice_id, invoice_item.quantity]
    end
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @repository.delete(item_to_delete)
  end

  def inspect
    "<#{self.class} #{@repository.size} rows>"
  end
end
