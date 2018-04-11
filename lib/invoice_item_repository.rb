require 'csv'
require_relative 'invoice_item'
require_relative 'repository'

# This class is a repo for invoice_items
class InvoiceItemRepository
  include Repository
  def initialize(engine = nil)
    @engine = engine
    @elements = {}
  end

  def build_elements_hash(elements)
    elements.each do |element|
      invoice_item = InvoiceItem.new(element, @engine)
      @elements[invoice_item.id] = invoice_item
    end
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    invoice_item = InvoiceItem.new(attributes, @engine)
    @elements[create_id_number] = invoice_item
  end

  # def update(id, attributes)
  #   super(id, attributes)
  #   attribute = attributes[:merchant_id]
  #   @elements[id].attributes[:merchant_id] = attribute if attribute
  # end
end
