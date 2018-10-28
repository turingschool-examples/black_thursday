require 'pry'
require 'CSV'
require_relative './repository'

class CustomerRepository < Repository

  def new_record(row)
    Customer.new(row)
  end

  def find_all_by_first_name(customer_name)
    @repo_array.find_all do |customer|
      customer.first_name == customer_name
    end
  end



end
