require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require_relative 'repository'

class InvoiceRepository
  include Repository

  def initialize(invoices)
    @list = invoices
  end

  def find_all_by_customer_id(id)
    @list.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_status(status)
    @list.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    highest_invoice_id = find_highest_id
    attributes[:id] = highest_invoice_id.id + 1
    @list << Invoice.new(attributes)
  end

  def update(id, attributes)
    if find_by_id(id)
      if attributes.key?(:status)
        find_by_id(id).status = attributes[:status]
      end
      find_by_id(id).updated_at = Time.now
    end
  end

end
