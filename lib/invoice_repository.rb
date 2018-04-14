# frozen_string_literal: true

require_relative 'base_repository'
require_relative 'invoice'
require 'pry'

# invoice repo
class InvoiceRepository < BaseRepository
  def invoices
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| Invoice.new(attribute_hash, self) }
  end

  def find_all_by_customer_id(customer_id)
    invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
  end

  # all - returns an array of all known Invoice instances
  # find_by_id - returns either nil or an instance of Invoice with a matching ID
  # find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
  # find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
  # find_all_by_status - returns either [] or one or more matches which have a matching status
  # create(attributes) - create a new Invoice instance with the provided attributes. The new Invoice’s id should be the current highest Invoice id plus 1.
  # update(id, attribute) - update the Invoice instance with the corresponding id with the provided attributes. Only the invoice’s status can be updated. This method will also change the invoice’s updated_at attribute to the current time.
  # delete(id) - delete the Invoice instance with the corresponding id
end
