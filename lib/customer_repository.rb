require_relative 'customer'
require          'pry'

class CustomerRepository
  attr_reader :customers

  def initialize(csv_hash)
    @customers ||= csv_hash.map {|csv_hash| Customer.new(csv_hash) }
  end

  def standard(data_to_be_standardized)
    data_to_be_standardized.to_s.downcase.gsub(" ", "")
  end

  def all
    customers
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(customer)
    customers.find {|cust| cust.id == customer.to_i}
  end

  def find_all_by_first_name(customer)
    customers.find_all do |cust|
      standard(cust.first_name).include?(standard(customer))
    end
  end

  def find_all_by_last_name(customer)
    customers.find_all do |cust|
      standard(cust.last_name).include?(standard(customer))
    end
  end

end
