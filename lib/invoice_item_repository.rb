# frozen_string_literal: true

require_relative './repository'
require_relative './invoice_item'
# holds Invoice Items
class InvoiceItemRepository
  include Repository
  attr_reader :repository

  def initialize(invoice_items)
    create_repository(invoice_items, InvoiceItem)
  end

  def create(attributes)
    general_create(attributes, InvoiceItem)
  end
end
