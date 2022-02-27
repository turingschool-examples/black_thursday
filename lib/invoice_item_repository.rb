require_relative '../lib/invoice_item'
require 'bigdecimal'
require 'CSV'
require 'time'


class InvoiceItemRepository

  attr_reader :filename, :invoice_items

  def initialize(filename)
    @filename = filename
    @invoice_items = self.all
  end

  def rows
    rows = CSV.read(@filename, headers: true, header_converters: :symbol)
  end

  def all
    rows.map {|row| InvoiceItem.new(row)}
  end

  def find_by_id(id)
    @invoice_items.find {|invoice_item| invoice_item.id == id}
  end

  def find_all_by_item_id(id)
    @invoice_items.find_all {|invoice_item| invoice_item.id == id}
  end

  def find_all_by_invoice_id(id)
    @invoice_items.find_all {|invoice_item| invoice_item.id == id}
  end

  def current_highest_id
    sorted = @invoice_items.sort_by {|invoice| invoice.id}
    highest_id = sorted[-1].id
  end

  def create(attributes)
    new_id = current_highest_id + 1
    attributes[:id] = new_id
    @invoice_items << new_invoice_item = InvoiceItem.new(attributes)
    new_invoice_item
  end

  def update(id, attributes)
    if updated_invoice = find_by_id(id)
      updated_invoice.quantity = attributes[:quantity]
      updated_invoice.unit_price = attributes[:unit_price]
      updated_invoice.updated_at = Time.now
    end
  end

  def delete(id)
    deleted_invoice = find_by_id(id)
    @invoice_items.delete(deleted_invoice)
  end

end
