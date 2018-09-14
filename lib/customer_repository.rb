# Create a repository of Item objects
#   - makes all item objects
#   - uses finder & CRUD modules

require 'pry'
require_relative 'item'
require_relative 'csv_parse'
require './lib/invoice'

class CustomerRepository
  include Finder

  attr_reader :all,
              :customers

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @customers = []
    make_customers
    @all = customers
  end

  def make_customers
    @csv.each { |key, value|
      hash = make_hash(key, value)
      customer = Customer.new(hash)
      @customers << customer
    }
  @customers.flatten!
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end
  

end