require 'csv'
require_relative 'invoice'
require_relative 'repository'

# This class is a repo for invoices
class InvoiceRepository
  include Repository
  def initialize
    @elements = {}
  end

  def build_elements_hash(elements)
    elements.each do |element|
      invoice = Invoice.new(element)
      @elements[invoice.id] = invoice
    end
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    invoice = Invoice.new(attributes)
    @elements[create_id_number] = invoice
  end

  def update(id, attributes)
    super(id, attributes)
    # binding.pry
    @elements[id].attributes[:merchant_id] = attributes[:merchant_id] if attributes[:merchant_id]
  end
end
