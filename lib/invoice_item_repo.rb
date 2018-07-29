require 'bigdecimal'
require_relative 'invoice_item'


class InvoiceItemRepo
  attr_accessor :invoice_items

  def initialize(invoice_items)
    @invoice_items = invoice_items
    change_invoice_item_hash_to_object
  end
  
  def change_invoice_item_hash_to_object
    invoice_items_array = []
    @invoice_items.each do |invoice_item|
      invoice_items_array << InvoiceItem.new(invoice_ite)
    end
    @invoice_items = invoice_items_array
  end
  
  def all
    @invoice_items
  end
  
  def find_by_id(id)
    @invoice_items.find do |invoice_item|
      invoice_item.id == id
    end
  end
  
  def find_all_by_item_id(item_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.id == item_id
    end
  end
  
  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all do |invoice_item|
      invoice_item.id == invoice_id
    end 
  end
  
  def create(attributes)
    invoice_item_new = InvoiceItem.new(attributes)
    max_invoice_item_id = @invoice_items.max_by do |invoice_item|
      invoice_item.id
    end
    new_max_id = max_invoice_item_id.id + 1
    invoice_item_new.id = new_max_id
    @invoice_items << invoice_item_new
    return invoice_item_new
  end 
  
  def update(id, attributes)
    invoice_item_to_change = find_by_id(id)
    return if invoice_item_to_change.nil?
    if attributes[:quantity]
      invoice_item_to_change.quantity = attributes[:quantity]
    end
    if attributes[:unit_price]
      invoice_item_to_change.unit_price = attributes[:unit_price].to_f * 100
    end
    invoice_item_to_change.updated_at = Time.now
    return invoice_item_to_change
  end
  
  def delete(id)
    invoice_item_to_delete = find_by_id(id)
    @invoice_items.delete(invoice_item_to_delete)
  end
  
  
  
  