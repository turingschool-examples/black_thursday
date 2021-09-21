# frozen_string_literal: true

require 'csv'
require_relative 'invoice_item'
require_relative 'csv_readable'

class InvoiceItemRepository
  include CSV_readable

  attr_reader :all

  def initialize(path)
    @all = generate(path)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def generate(path)
    rows = read_csv(path)

    rows.map do |row|
      InvoiceItem.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |row|
      row.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |row|
      row.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |row|
      row.invoice_id == invoice_id
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s

    @all << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item_to_update = find_by_id(id)
    if attributes[:quantity] != nil
      invoice_item_to_update.update_quantity(attributes[:quantity])
    end
    if attributes[:unit_price] != nil
      invoice_item_to_update.update_unit_price(attributes[:unit_price])
    end
    if invoice_item_to_update
    invoice_item_to_update.update_updated_at
    end
    invoice_item_to_update
  end

  def delete(id)
    invoice_item_to_delete = find_by_id(id)
    @all.delete(invoice_item_to_delete)
  end
end
