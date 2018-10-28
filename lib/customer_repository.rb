require 'time'
require_relative '../lib/customer'
require_relative '../lib/repository'

class CustomerRepository
  include Repository

  def initialize(customers)
    @collection = customers
  end

  def find_all_by_first_name(name)
    all.find_all do |first|
      first.first_name.upcase.include?(name.upcase)
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |last|
      last.last_name.upcase.include?(name.upcase)
    end
  end
  #What's needed
  def create(attributes)
    new_id = max_id + 1
    first_name = attributes[:first_name]
    last_name = attributes[:last_name]
    created_at = Time.now.to_s
    updated_at = Time.now.to_s
    new_customer = Customer.new({id: new_id, first_name: first_name,
    last_name: last_name, created_at: created_at,
    updated_at: updated_at})
    @collection << new_customer
    new_customer
  end
  #create
  #update
  #delete


end
