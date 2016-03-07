require 'pry'

class CustomerRepository

  attr_accessor :repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @repository = []
  end

  def all
    repository
  end

  def find_by_id(id)
    repository.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name)
    repository.find_all do |customer|
      customer.first_name.upcase.include?(name.upcase)
    end
  end

  def find_all_by_last_name(name)
    repository.find_all do |customer|
      customer.last_name.upcase.include?(name.upcase)
    end
  end

  def inspect
  end

end
