require_relative '../lib/modules/repo_queries'

class InvoiceItemRepository
  include RepoQueries

  attr_reader :data, :engine

  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
    @child = InvoiceItem
    load_data(file)
  end
end
