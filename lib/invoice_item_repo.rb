require 'pry'

class InvoiceItemRepository
  attr_reader :file_path, :invoice_items
  def initialize(file_path)
    @file_path = file_path
    @invoice_items = all
  end

  def all
    invoice_items = CSV.read(@file_path, headers: true, header_converters: :symbol)
    invoice_items_instances_array = []
    invoice_items.by_row!.each do |row|
      invoice_items_instances_array << InvoiceItem.new(row)
    end
    invoice_items_instances_array
  end

  def find_by_id(id)
    invoice_items.find do |iii|
      iii.invoice_item_attributes[:id] == id
    end
  end

  def find_all_by_item_id(id)
    invoice_items.find_all do |instance|
      instance.invoice_item_attributes[:item_id] == (id)
    end
  end

  def find_all_by_invoice_id(id)
    invoice_items.find_all do |instance|
      instance.invoice_item_attributes[:invoice_id] == (id)
    end
  end

  def create(attributes)
    attributes[:id] = invoice_items[-1].invoice_item_attributes[:id] + 1
    invoice_items << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    if !(attributes.include?(:id) || attributes.include?(:item_id) || attributes.include?(:invoice_id) || attributes.include?(:created_at) || attributes.include?(:updated_at))
      find_by_id(id).invoice_item_attributes[:quantity] = attributes[:quantity]
      find_by_id(id).invoice_item_attributes[:unit_price] = attributes[:unit_price]
    end
    find_by_id(id).invoice_item_attributes[:updated_at] = Time.now
  end

  def delete(id)
    invoice_items.delete(find_by_id(id))
  end
end
