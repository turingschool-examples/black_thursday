require 'csv'
require_relative './sales_engine'

class InvoiceItemRepository

  def initialize(data)
    @invoice_items = data
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    invoice_item_id = nil
    @invoice_items.select do |invoice_item|
      if invoice_item.id == id
        invoice_item_id = invoice_item
      end
    end
    invoice_item_id
  end

  def find_all_by_item_id(id)
    @invoice_items.find_all do |invoice_item|
      if invoice_item.item_id == id
        invoice_item
      end
    end
  end

  def find_all_by_invoice_id(id)
    @invoice_items.find_all do |invoice_item|
      if invoice_item.invoice_id == id
        invoice_item
      end
    end
  end

  def highest_id
    new = @invoice_items.max_by(&:id)
    new.id + 1
  end

  def create(attributes)
    new_invoice_item = InvoiceItem.new([highest_id, attributes[:item_id], attributes[:invoice_id], attributes[:quantity], attributes[:unit_price], Time.now.strftime('%Y-%m-%d'), Time.now.strftime('%Y-%m-%d')])
      @invoice_items << new_invoice_item
  end

  def update(id, attributes)
    @invoice_items.map do |invoice_item|
      if invoice_item.id == id
        invoice_item.quantity = attributes[:quantity]
        invoice_item.unit_price = attributes[:unit_price]
        invoice_item.updated_at = Time.now
      end
    end
  end

  def delete(id)
    trash = @invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
    @invoice_items.delete(trash)
  end
end
