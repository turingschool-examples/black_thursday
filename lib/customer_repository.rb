require 'time'
require_relative '../lib/customer'
require_relative '../lib/repository'

class CustomerRepository
  include Repository

  def initialize(customers)
    @collection = customers
  end

  #What's needed
  #find_by_id
  #find_all_by_first_name
  #find_all_by_last_name
  #create
  #update
  #delete


end
