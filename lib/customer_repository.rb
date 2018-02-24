require 'csv'
require_relative 'customer'
require 'pry'

class CustomerRepository

  attr_reader :engine

  def initialize(filepath, parent = nil)
    @customers    = []
    @engine       = parent
    load_items(filepath)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    @customers
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @customers << Customer.new(data, self)
    end
  end

  def find_by_id(id)
    @customers.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    @customers.find_all { |customer| customer.first_name == name }
  end

  def find_all_by_last_name(name)
    @customers.find_all { |customer| customer.last_name == name }
  end

end
