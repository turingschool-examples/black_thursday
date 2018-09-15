require 'pry'

require_relative 'csv_parse'
require_relative 'customer'

class CustomerRepository

  attr_reader :all,
              :customers

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @customers = []
    make_customers
    @all = customers # retains permissions
  end

  def make_customers
    @csv.each { |key, value|
      hash = make_hash(key, value)
      customer = Customer.new(hash)
      @customers << customer
    }
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end


end
