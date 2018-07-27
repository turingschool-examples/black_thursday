require 'csv'
require_relative '../lib/customer.rb'
require_relative '../lib/repo_method_helper.rb'
require 'pry'

class CustomerRepository
  attr_reader :customers
  include RepoMethodHelper

  def initialize(customer_location)
    @customer_location = customer_location
    @customers = []
    from_sales_engine
  end

  def from_sales_engine
    CSV.foreach(@customer_location, headers: true, header_converters: :symbol) do |row|
      @customers << Customer.new(row)
    end
  end

  def all
    @customers
  end

  def find_all_by_first_name(first_name)
    downcased_first_name = first_name.downcase
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(downcased_first_name)
    end
  end

  def find_all_by_last_name(last_name)
    downcased_last_name = last_name.downcase
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(downcased_last_name)
    end
  end

  def create(attributes)
    attributes[:id] = create_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    created = Customer.new(attributes)
    @customers << created
    created
  end

  def update(id, attributes)
    find_by_id(id).first_name = attributes[:first_name] unless attributes[:first_name].nil?
    find_by_id(id).last_name = attributes[:last_name] unless attributes[:last_name].nil?
    find_by_id(id).updated_at = Time.now unless find_by_id(id).nil?
  end
end
