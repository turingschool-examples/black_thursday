# frozen_string_literal: true

require './lib/general_repo'
require './lib/invoice_item'

# this is the InvoiceItemRepository class
class InvoiceItemRepository < GeneralRepo
  def initialize(data)
    super('InvoiceItem', data)
  end

  def find_all_by_item_id(item_id)
    repository.find_all do |ii|
      ii.item_id == item_id.to_s
    end
  end

  def find_all_by_invoice_id(invoice_id)
    repository.find_all do |ii|
      ii.invoice_id == invoice_id.to_s
    end
  end
end
