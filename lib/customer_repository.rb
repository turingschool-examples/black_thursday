# frozen_string_literal: true

# This is a CustomerRepository class for Black Thursday

require_relative 'customer'

class CustomerRepository
  attr_reader :all

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

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
      customer if customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |customer|
      customer if customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    creation_time = Time.now.to_s
    all << Customer.new(
      id: most_recent_customer.id.to_i + 1,
      first_name: attributes[:first_name],
      last_name: attributes[:last_name],
      created_at: creation_time,
      updated_at: creation_time
    )
  end

  def most_recent_customer
    all.max_by(&:id)
  end

  def update(id, attribute)
    find_by_id(id).update(attribute) unless find_by_id(id).nil?
  end

  def delete(id)
    all.delete(find_by_id(id)) unless find_by_id(id).nil?
  end
end
