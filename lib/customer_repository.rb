require_relative 'customer'
require_relative 'repo_methods'

class CustomerRepository
  include RepoMethods
  def initialize(customer_data)
    @customer_rows ||= build_customer(customer_data)
    @repo = @customer_rows #shops = an array of customers, might change this name
  end

  def build_customer(customer_data)
    customer_data.map do |customer|
      Customer.new(customer)
    end
  end
end 
