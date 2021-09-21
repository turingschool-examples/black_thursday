require 'csv'
require './lib/sales_engine'
require './lib/customer'

class CustomerRepository
  attr_reader :all
  def initialize(customer_path)
    @all = (
      customer_objects = []
      CSV.foreach(customer_path, headers: true, header_converters: :symbol) do |row|
        customer_objects << Customer.new(row)
      end
      customer_objects)
  end

  def find_by_id(id)
    if (@all.any? do |customer|
      customer.id == id
    end) == true
      @all.find do |customer|
        customer.id == id
      end
    else
      nil
    end
  end
end
