require 'csv'
require 'time'
require_relative '../lib/customer'

class CustomerRepo
  attr_reader :customers, :parent

  def initialize(file,se=nil)
    open_file(file)
    @parent = se
  end

  def open_file(file)
    csv = CSV.foreach file,
    headers: true, header_converters: :symbol
    @customers = csv.map do |row|
      Customer.new(row, self)
    end
  end

  def all
    customers
  end

  def find_by_id(customer_id)
    customers.find {|customer| customer.id == customer_id}
  end

  def find_all_by_first_name(first_name)
    customers.find_all {|customer| customer.first_name.downcase.include?(first_name.downcase)}
  end

  def find_all_by_last_name(last_name)
    customers.find_all {|customer| customer.last_name.downcase.include?(last_name.downcase)}
  end

  def customer_merchants(id)
    parent.customer_merchants(id)
  end

end
