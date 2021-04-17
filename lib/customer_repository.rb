require_relative '../lib/customer'
require_relative '../lib/repository'

class CustomerRepository < Repository

  def initialize(path)
    super(path)
    @array_of_objects = create_customers(@parsed_csv_data)
  end

  def create_customers(parsed_csv_data)
    parsed_csv_data.map do |customer|
      Customer.new(customer)
    end
  end

  def create(attributes)
    max_id = @array_of_objects.max_by do |customer|
      customer.id
    end.id

    new_customer = Customer.new(attributes)
    new_customer.id = max_id + 1
    @array_of_objects << new_customer
  end

end
