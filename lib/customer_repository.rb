require 'csv'
require_relative 'customer'

class CustomerRepository
  attr_reader :customers,
              :parent

  def initialize(path, sales_engine = "")
    @customers = {}
    @parent    = sales_engine
    customer_creator_and_storer(path)
  end

  def customer_creator_and_storer(path)
    # argument_raiser(path, String)
    csv_opener(path).each do |customer|
      new_customer = Customer.new(customer, self)
      @customers[new_customer.id] = new_customer
    end
  end

  def csv_opener(path = "./data/customers.csv")
    # argument_raiser(path, String)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def all
    @customers.values
  end

  def find_by_id(id)
    argument_raiser(id)
    @customers[id]
  end

  def find_all_by_first_name(first_name)
    all.select do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    all.select do |customer|
      customer.last_name == last_name
    end
  end

  def argument_raiser(data_type, desired_class = Integer)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

end
