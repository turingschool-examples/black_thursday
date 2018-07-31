require_relative '../lib/customer.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/repository_helper.rb'
require 'csv'

class CustomerRepository
  include RepositoryHelper
  attr_reader :all,
              :customers
  def initialize(filepath)
    @filepath = filepath
    @all = [ ]
    @customers = [ ]
  end

  def create_customers
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new(row)
    end
  end

  def find_all_by_first_name(name)
    @all.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @all.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    id = create_id
    customer = Customer.new(
      id: id,
      first_name: attributes[:first_name],
      last_name:  attributes[:last_name],
      created_at: Time.now,
      updated_at: Time.now)
    @all << customer
    customer
  end

  def update (id, attributes)
    customer = find_by_id(id)
    return if customer.nil?
    customer.first_name = attributes[:first_name] || customer.first_name
    customer.last_name = attributes[:last_name] || customer.last_name
    customer.updated_at = Time.now
    customer
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
 end
end
