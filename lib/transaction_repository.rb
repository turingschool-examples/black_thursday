require_relative '../lib/modules/repo_queries'
class TransactionRepository
  include RepoQueries
  attr_reader :data
  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
  end
end
