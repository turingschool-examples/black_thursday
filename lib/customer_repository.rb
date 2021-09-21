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
end
