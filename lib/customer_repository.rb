require_relative 'customer'
require          'pry'

class CustomerRepository
  attr_reader :customers

  def initialize(csv_hash)
    @customers = csv_hash.map {|csv_hash| Customer.new(csv_hash) }
  end

  def all
    customers
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end




end


# all - returns an array of all known Customers instances
# find_by_id - returns either nil or an instance of InvoiceItem with a matching ID
# find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
# find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
