require 'csv'
require_relative 'customer.rb'

class CustomerRepository
  def initialize(filepath, parent)
    @customers = []
    @parent = parent
    load_items(filepath)
  end

  def all
    @customers
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @customers << Customer.new(row, self)
    end
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
      customer.first_name.downcase == first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    @customers.find_all do |customer|
      customer.last_name.downcase == last_name.downcase
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
