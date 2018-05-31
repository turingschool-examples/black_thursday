require_relative 'customer'
require_relative 'repository'

class CustomerRepository
  include Repository
  # Responsible for holding and searching InvoiceItem instances.
  attr_reader :customers

  def initialize(customers)
    @customers = customers
    @repository = []
    create_all_customers
  end

  def create_all_customers
    @customers.each do |customer|
      @repository << Customer.new(customer)
    end
  end

  def create(attributes)
    highest_id = @repository.max_by { |customer| customer.id }
    attributes[:id] = highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @repository << Customer.new(attributes)
  end

  def find_all_by_first_name(name)
    @repository.find_all do |element|
      element.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @repository.find_all do |element|
      element.last_name.downcase.include?(name.downcase)
    end
  end
end
