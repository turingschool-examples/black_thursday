require 'pry'

class CustomerRepository
  attr_reader :file_path, :customers
  def initialize(file_path)
    @file_path = file_path
    @customers = all
  end

  def all
    customers = CSV.read(@file_path, headers: true, header_converters: :symbol)
    customers_instances_array = []
    customers.by_row!.each do |row|
      customers_instances_array << Customer.new(row)
    end
    customers_instances_array
  end

  def find_by_id(id)
    customers.find do |customer_instance|
      customer_instance.customer_attributes[:id] == id
    end
  end

  def find_all_by_first_name(first_name)
    customers.find_all do |customer_instance|
      customer_instance.customer_attributes[:first_name] == first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    customers.find_all do |customer_instance|
      customer_instance.customer_attributes[:last_name] == last_name.downcase
    end
  end

  def create(attributes)
    attributes[:id] = customers[-1].customer_attributes[:id] + 1
    attributes[:created_at] = Time.now
    attributes[:updated_at] = Time.now
    customers << Customer.new(attributes)
  end

  def update(id, attributes)
    if !(attributes.include?(:id) || attributes.include?(:created_at) || attributes.include?(:updated_at))
      find_by_id(id).customer_attributes[:first_name] = attributes[:first_name]
      find_by_id(id).customer_attributes[:last_name] = attributes[:last_name]
    end
    find_by_id(id).customer_attributes[:updated_at] = Time.now
  end

  def delete(id)
    customers.delete(find_by_id(id))
  end
end
