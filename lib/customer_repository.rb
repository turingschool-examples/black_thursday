require 'csv'
require 'date'
require_relative 'customer'
require_relative 'sales_module'

class CustomerRepository
  include SalesModule
  attr_reader :all, :customers
  def initialize(csv)
    @all = Customer.read_file(csv)
  end

  def find_by_id(id)
    @all.find{|customer| customer.id == id}
  end

  def find_all_by_first_name(first_name)
    found = []
    found << @all.find_all{|customer| customer.first_name == first_name}
  end

  def find_all_by_last_name(last_name)
    found = []
    found << @all.find_all{|customer| customer.last_name == last_name}
  end

  def create(data)
    new_customer = Customer.new({
      id: (@all[-1].id + 1),
      first_name: data[:first_name],
      last_name: data[:last_name],
      created_at: Date.today.to_s,
      updated_at: Date.today.to_s})
      @all << new_customer
  end

  def update(id, first_name, last_name)
    updated_customer = @all.find{|customer| customer.id == id}
    updated_customer.first_name = first_name
    updated_customer.last_name = last_name
    updated_customer.updated_at = Date.today.to_s
  end


end
