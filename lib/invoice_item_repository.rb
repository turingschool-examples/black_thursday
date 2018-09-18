require_relative '../lib/invoice_item'
require_relative '../lib/repo_module'
require 'bigdecimal'
require 'time'

class InvoiceItemRepository
  include RepoModule

  attr_accessor :quantity,
                :unit_price,
                :updated_at
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  def initialize
    @data = []
  end

  def create(attributes)
    #all incoming data must be formatted as String datatype
    if attributes[:id] != nil
      #Coming From CSV
      hash = {
        id:         attributes[:id].to_i,
        item_id:    attributes[:item_id].to_i,
        invoice_id: attributes[:invoice_id].to_i,
        quantity:   attributes[:quantity].to_i,
        unit_price: BigDecimal.new(attributes[:unit_price].to_f/100, attributes[:unit_price].length),
        updated_at: Time.parse(attributes[:updated_at]),
        created_at: Time.parse(attributes[:created_at]),
      }
      invoice_item = InvoiceItem.new(hash)
      @data << invoice_item
    else
      #Generated on the fly
      hash = {
        id:         find_next_id,
        item_id:    attributes[:item_id].to_i,
        invoice_id: attributes[:invoice_id].to_i,
        quantity:   attributes[:quantity].to_i,
        unit_price: attributes[:unit_price],
        updated_at: attributes[:updated_at],
        created_at: attributes[:created_at]
        }
      invoice_item = InvoiceItem.new(hash)
      @data << invoice_item
    end
  end

  def find_all_by_invoice_id(id)
    @data.find_all do |element|
      element.invoice_id == id
    end
  end

  def find_all_by_item_id(id)
    @data.find_all do |element|
      element.item_id == id
    end
  end

# update(id, attribute) - update the InvoiceItem instance with the corresponding id with the provided attributes. Only the invoice_item’s quantity and unit_price can be updated. This method will also change the invoice_item’s updated_at attribute to the current time.
# delete(id) - delete the InvoiceItem instance with the corresponding idte(id, attribute) - update the Transaction instance with the corresponding id with the provided attributes. Only the transaction’s credit_card_number, credit_card_expiration_date, and result can be updated. This method will also change the transaction’s updated_at attribute to the current time.

end
