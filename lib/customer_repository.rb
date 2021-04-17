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

  def update(id, attributes)
    target = find_by_id(id)
    if target != nil
      target.first_name = attributes[:first_name] if attributes[:first_name] != nil
      target.last_name = attributes[:last_name] if attributes[:last_name] != nil
      target.updated_at = Time.now
    end
  end

  def find_all_by_first_name(first_name)
    @array_of_objects.find_all do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    @array_of_objects.find_all do |customer|
      customer.last_name == last_name
    end
  end
end
