# frozen_string_literal: true

# This is a CustomerRepository class for Black Friday

class CustomerRepository
  attr_reader :all

  def initialize(customer_data)
    @all = fill_customers(customer_data)
  end

  def fill_customers(customer_data)
    all_customers = CSV.parse(File.read(customer_data))
    categories = all_customers.shift
    all_customers.map do |customer|
      individual_customer = {}
      categories.zip(customer) do |category, attribute|
        individual_customer[category.to_sym] = attribute
      end
      Customer.new(individual_customer)
    end
  end

  def find_by_id(id)
    all.find { |customer| customer.id.to_i == id.to_i }
  end

  def find_all_by_first_name(name)
    all.find_all do |customer|
      customer.first_name == name
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |customer|
      customer.last_name == name
    end
  end

  def create(first_name, last_name)
    creation_time = Time.now
    all << Customer.new(
      id: most_recent_customer.id.to_i + 1,
      first_name: first_name,
      last_name: last_name,
      created_at: creation_time,
      updated_at: creation_time
    )
  end

  def most_recent_customer
    all.max_by(&:id)
  end

  def update(id, attribute)
    find_by_id(id).update(attribute)
  end
end
