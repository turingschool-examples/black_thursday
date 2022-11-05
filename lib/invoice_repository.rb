require_relative '../lib/modules/repo_queries'
require_relative '../lib/invoice'

class InvoiceRepository
  include RepoQueries

  attr_reader :data, :engine

  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
    load_data(file)
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

  def update(id, attributes)
    return if attributes.empty?
    updated = find_by_id(id)
    updated.status = attributes[:status]
    updated.updated_at = Time.now
  end

  def child
    Invoice
  end
end
