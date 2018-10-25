require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  attr_reader :type, :attr_whitelist
  def initialize
    @type = Customer
    @attr_whitelist = [:first_name, :last_name]
    super
  end

  def find_all_by_first_name(first_name)
    @instances.find_all {|customer| customer.first_name.include?(first_name.downcase)}
  end

  def find_all_by_last_name(last_name)
    @instances.find_all {|customer| customer.last_name.include?(last_name.downcase)}
  end
end
