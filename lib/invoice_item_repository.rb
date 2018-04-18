# frozen_string_literal: true

require_relative 'base_repository'
require_relative 'invoice_item'

# invoice item repo
class InvoiceItemRepository < BaseRepository
  def invoice_items
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| InvoiceItem.new(attribute_hash, self) }
  end

  def find_all_by_item_id(id)
    invoice_items.select { |invoice_item| invoice_item.item_id == id }
  end

  def find_all_by_invoice_id(id)
    invoice_items.select { |invoice_item| invoice_item.invoice_id == id }
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    invoice_items << InvoiceItem.new(attributes, 'parent')
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    to_update = find_by_id(id)
    to_update.change_updated_at
    to_update.change_unit_price(attributes[:unit_price])
    to_update.change_quantity(attributes[:quantity])
  end
end
