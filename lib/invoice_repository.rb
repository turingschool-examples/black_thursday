require_relative '../lib/modules/repo_queries'

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
end