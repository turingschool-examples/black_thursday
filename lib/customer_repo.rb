require_relative './customer'
require 'time'
require 'csv'
require 'bigdecimal'

class CustomerRepo
  attr_reader :customer_list

  def initialize(csv_files, engine)
    @customer_list = customer_instances(csv_files)
    @engine = engine
  end

  def customer_instances(csv_files)
    customers = CSV.open(csv_files, headers: true, header_converters: :symbol)

    @customer_list = customers.map do |customer|
      Customer.new(customer, self)
    end
  end

  def all
    @customer_list
  end

  def find_by_id(id)
    @customer_list.find do |customer|
      customer.id == id
    end
  end
end
