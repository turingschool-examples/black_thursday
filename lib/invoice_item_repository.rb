require 'csv'
require_relative 'invoice_item'
require_relative 'repository'

# This class is a repo for invoice_items
class InvoiceItemRepository
  include Repository
  def initialize
    @elements = {}
    @invoice_ids = Hash.new{ |h, k| h[k] = [] }
  end

  def build_elements_hash(elements)
    elements.each do |element|
      invoice_item = InvoiceItem.new(element)
      @elements[invoice_item.id] = invoice_item
      @invoice_ids[invoice_item.invoice_id] << invoice_item

    end
  end

  def find_all_by_item_id(item_id)
    all.find_all do |element|
      element.item_id == item_id
    end
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    invoice_item = InvoiceItem.new(attributes)
    @elements[create_id_number] = invoice_item
  end
end
