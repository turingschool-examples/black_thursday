# frozen_string_literal: false

require_relative 'customer'
require_relative 'repository'
# Responsible for holding and searching Customer instances
class CustomerRepository
  include Repository
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
    attributes[:id] = find_highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @repository << Customer.new(attributes)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    unless customer.nil?
      customer.first_name = attributes[:first_name] if attributes[:first_name]
      customer.last_name  = attributes[:last_name] if attributes[:last_name]
      customer.updated_at = Time.now
    end
    return nil
  end

  def find_all_by_first_name(name)
    @repository.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @repository.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end
end
