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

  def create(attributes)
    general_create(attributes, InvoiceItem)
  end

end
