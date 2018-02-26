require 'csv'
require_relative 'customer'
require_relative 'repository'

# Customer Repo
class CustomerRepository
  include Repository
  attr_reader :engine

  def initialize(filepath, parent = nil)
    @csv_items = []
    @engine       = parent
    load_children(filepath)
  end

  def customers
    @csv_items
  end

  def child
    Customer
  end

  def find_all_by_first_name(name)
    customers.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    customers.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end
end
