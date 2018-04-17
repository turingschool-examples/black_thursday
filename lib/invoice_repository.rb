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

  def find_all_by_customer_id(input)
    @repository.values.find_all do |invoice|
      invoice.customer_id == input
    end
  end

  def find_all_by_status(input)
    @repository.values.find_all do |invoice|
      invoice.status == input
    end
  end

  def create(attributes)
    general_create(attributes, Invoice)

  end
end
