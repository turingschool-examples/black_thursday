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

  def update(id, attributes)
    return if attributes.empty?
    updated = find_by_id(id)
    updated.first_name = attributes[:first_name]
    updated.last_name = attributes[:last_name]
    updated.updated_at = Time.now
  end
end