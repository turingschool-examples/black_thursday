require 'pry'

class CustomerRepository

  attr_reader :customers, :sales_engine

  def initialize(customers, sales_engine = nil)
    @customers     = customers
    @sales_engine  = sales_engine
  end

  def all
    customers
  end

  def find_by_id(id)
    customers.find { |row| row.id == id }
  end

  def find_all_by_first_name(first_name)
    customers.select do |row|
      row.first_name.downcase.include?  first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    customers.select do |row|
      row.last_name.downcase.include? last_name.downcase
    end
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
