require 'csv'
require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository

  attr_reader :klass, :data

  def initialize(sales_engine, path)
    super(sales_engine, path, Customer)
  end

  def all
    data
  end

end
