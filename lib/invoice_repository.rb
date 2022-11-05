require_relative '../lib/modules/repo_queries'
require_relative '../lib/invoice'

class InvoiceRepository
  include RepoQueries

  attr_reader :data

  def initialize(file = nil, engine = nil)
    @data = []
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      invoice.status.casecmp?(status)
    end
  end

  def child
    Invoice
  end
end