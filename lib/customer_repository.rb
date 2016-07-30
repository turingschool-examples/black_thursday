require_relative '../lib/customer'

class CustomerRepository
  attr_reader :list_of_customers

  extend Forwardable
  def_delegators :@parent_engine, :find_merchants

  def initialize(customers_data, parent_engine)
    @parent_engine = parent_engine
    @list_of_customers = populate_customers(customers_data)
  end

  def populate_customers(customers_data)
    customers_data.map do |datum|
      Customer.new(datum, self)
    end
  end

  def all
    list_of_customers
  end

  def find_by_id(id_to_find)
    list_of_customers.find do |customer|
      customer.id == id_to_find
    end
  end

  def find_all_by_first_name(name_fragment_to_find)
    list_of_customers.find_all do |customer|
      customer.first_name.downcase.include?(name_fragment_to_find.downcase)
    end
  end

  def find_all_by_last_name(name_fragment_to_find)
    list_of_customers.find_all do |customer|
      customer.last_name.downcase.include?(name_fragment_to_find.downcase)
    end
  end

  # just for the spec harness
  def inspect
  end

end
