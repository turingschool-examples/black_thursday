require_relative '../lib/modules/repo_queries'
class TransactionRepository
  include RepoQueries
  attr_reader :data
  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end
end
