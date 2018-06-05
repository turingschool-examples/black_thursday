require_relative 'repository_helper.rb'
require_relative 'customer.rb'

class CustomerRepository
  include RepositoryHelper
  attr_reader :repository

  def initialize(file_contents)
    @repository = file_contents.map { |customer| Customer.new(customer) }
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

  def create(attributes)
    sorted = @repository.sort_by(&:id)
    new_id = sorted.last.id + 1
    attributes[:id] = new_id
    new_customer = Customer.new(attributes)
    @repository << new_customer
    new_customer
  end

  def update(id, attributes)
    customer = find_by_id(id)
    return if customer.nil?
    attributes.each do |key, value|
      customer.first_name = value if key == :first_name
      customer.last_name = value if key == :last_name
    end
    customer.updated_at = Time.now + 1
    customer
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
