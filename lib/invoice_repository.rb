# frozen_string_literal: true

require_relative './repository'
require_relative './invoice'
# holds invoices and allows for basic invoice creation and retrieval
class InvoiceRepository
  include Repository
  attr_reader :repository

  def initialize(invoices)
    create_repository(invoices, Invoice)
  end

  def create(attributes)
    general_create(attributes, Invoice)
  end
end
