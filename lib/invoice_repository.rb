require_relative './invoice'
require_relative './repository'
require 'time'

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
