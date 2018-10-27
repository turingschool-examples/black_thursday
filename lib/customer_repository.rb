require 'pry'
require 'CSV'
require_relative './repository'

class CustomerRepository < Repository

  def new_record(row)
    Customer.new(row)
  end

end
