require_relative '../lib/modules/repo_queries'

class InvoiceRepository
  include RepoQueries

  attr_reader :data

  def initialize
    @data = []
  end
end