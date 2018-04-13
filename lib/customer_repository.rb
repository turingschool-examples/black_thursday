require 'csv'
require_relative 'customer'
require_relative 'repository'

# This class is a repo for customers
class CustomerRepository
  include Repository
  def initialize(engine = nil)
    @engine = engine
    @elements = {}
  end

  def build_elements_hash(elements)
    elements.each do |element|
      customer = Customer.new(element, @engine)
      @elements[customer.id] = customer
    end
  end

  def find_all_by_first_name(first_name)
    all.find_all do |element|
      element.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |element|
      element.last_name.downcase.include?(last_name.downcase)
    end
  end

  def create(attributes)
    create_id_number
    attributes[:id] = create_id_number
    customer = Customer.new(attributes, @engine)
    @elements[create_id_number] = customer
  end
end
