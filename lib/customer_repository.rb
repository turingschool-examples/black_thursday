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

  def find_all_by_first_name(fragment)
    @repo.find_all do |customer|
      customer.first_name.downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_last_name(fragment)
    @repo.find_all do |customer|
      customer.last_name.downcase.include?(fragment.downcase)
    end
  end
end
