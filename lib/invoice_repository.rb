require_relative '../lib/modules/repo_queries'

class InvoiceRepository
  include RepoQueries

  attr_reader :data

  def initialize(file = nil, engine = nil)
    @data = []
  end
end