require_relative 'customer'
require 'pry'

class CustomerRepository

  def initialize(filepath, parent = nil)
    @customers = []
    load_customers(filepath)
    @parent    = parent
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def load_customers(filepath)
    CSV.foreach(filepath, headers: true,
                header_converters: :symbol) do |data|
      @customers << Customer.new(data, self)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_by_first_name(name)
    @customers.find_all do |customer|
      customer.first_name == name
    end
  end

  def find_by_last_name(name)
    @customers.find_all do |customer|
      customer.last_name == name
    end
  end
end
