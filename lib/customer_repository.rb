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

  def create(attributes)
    id = create_id
    customer = Customer.new(
      id: id,
      first_name: attributes[:first_name],
      last_name: attributes[:last_name],
      created_at: Time.now,
      updated_at: Time.now,
      )
    @repo << customer
    customer
  end

  def update(id, attributes)
    customer = find_by_id(id)
    return if customer.nil?
    customer.first_name = attributes[:first_name] || customer.first_name
    customer.last_name = attributes[:last_name] || customer.last_name
    customer.updated_at = Time.now
    customer
  end
end
