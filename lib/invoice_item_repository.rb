require_relative '../lib/invoice_item'
require_relative '../lib/repo_module'
require 'bigdecimal'
require 'time'

class InvoiceItemRepositoy
  include RepoModule

  def initialize
    @data = []
  end

  def create(attributes)
    hash = {}
    if attributes[:id] != nil
      hash[:id] = attributes[:id].to_i
    else
      attributes[:id] = find_by_id
    end
      hash[:item_id] = attributes[:item_id].to_i
      hash[:invoice_id] = attributes[:invoice_id].to_i
      hash[:quantity] = attributes[:quantity]
      hash[:unit_price] = BigDecimal.new(attributes[:unit_price].to_f/100, attributes[:unit_price].length)
      hash[:created_at] = Time.parse(attributes[:created_at])
      hash[:updated_at] = Time.parse(attributes[:updated_at])
      @data << InvoiceItem.new(hash)
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
