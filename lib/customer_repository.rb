require_relative '../lib/modules/repo_queries'
require_relative '../lib/customer'
class CustomerRepository
  include RepoQueries

  attr_reader :data, 
              :engine,
              :child

  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
    @child = Customer
    load_data(file)
  end
end