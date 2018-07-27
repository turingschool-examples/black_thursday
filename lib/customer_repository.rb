require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'repository'

class CustomerRepository
  include Repository

  def initialize(customers)
    @list = customers
  end

  def find_all_by_first_name(name)
    @list.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end
end
