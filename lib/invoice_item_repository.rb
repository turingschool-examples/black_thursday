require_relative './repository'
require_relative './invoice_item'
require 'bigdecimal'
require 'time'

class InvoiceItemRepository
  include Repository
  attr_reader   :repository

  def initialize(invoice_items)
    create_repository(invoice_items, InvoiceItem)
  end

  def find_all_by_item_id(ii)
    @repository.values.find_all do |invoice_item|
      invoice_item.item_id == ii
    end
  end

  def find_all_by_invoice_id(ii)
    @repository.values.find_all do |invoice_item|
      invoice_item.invoice_id == ii
    end
  end

  def create(attributes)
    general_create(attributes, InvoiceItem)
  end


end
