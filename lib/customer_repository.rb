require_relative 'customer'
require 'pry'

class CustomerRepository

  attr_reader   :parent,
                :all

  def initialize(customer_data, parent = nil)
    @parent = parent
    @all = populate(customer_data)
  end

  def populate(customer_data)
    customer_data.map { |customer| Customer.new(customer, self) }
  end

  def find_by_id(id)
    all.find { |customer| customer.id.eql?(id) }
  end

  def find_all_by_first_name(first_name)
    all.find_all {|customer| customer.first_name.downcase.include?(first_name.downcase)}
  end

  def find_all_by_last_name(last_name)
    all.find_all {|customer| customer.last_name.downcase.include?(last_name.downcase)}
  end

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end
end