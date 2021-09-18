require 'csv'
require_relative '../lib/invoice_item'

class InvoiceItemRepo
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def to_array
    invoice_items = []

    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      headers = row.headers
      invoice_items << row.to_h
    end
    invoice_items.map do | invoice_item |
      InvoiceItem.new(invoice_item)
    end
  end

  def find_by_id(id)
    all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    all.select do |invoice_item|
      item_id == invoice_item.item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.select do |invoice_item|
      invoice_id == invoice_item.invoice_id
    end
  end

  def find_highest_id
    highest = all.max_by do |invoice_item|
      invoice_item.id
    end
    highest.id
  end

  def create(attributes)
    id = find_highest_id + 1
    attributes = {
              id: id.to_s,
         item_id: attributes[:item_id],
      invoice_id: attributes[:invoice_id],
        quantity: attributes[:quantity],
      unit_price: attributes[:unit_price],
      created_at: attributes[:created_at].to_s,
      updated_at: attributes[:updated_at].to_s
    }
    @all << InvoiceItem.new(attributes)
    end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    invoice_item.change_quantity(attributes[:quantity])
    invoice_item.change_unit_price(attributes[:unit_price])
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end

end
