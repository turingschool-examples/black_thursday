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

  def find_by_id(id)
    data.select { |customer| customer.id == id }.first
  end

  def find_all_by_first_name(first)
    data.select { |customer| customer.first_name.upcase.include?(first.upcase) }
  end

  def find_all_by_last_name(last)
    data.select { |customer| customer.last_name.upcase.include?(last.upcase) }
  end

end
