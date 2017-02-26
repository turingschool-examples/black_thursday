require 'csv'
require 'time'
require_relative './customer'
require 'pry'

class CustomerRepository
  attr_accessor :customer_array
  attr_reader :contents, :engine

  def initialize(path, engine = '')
    @customers_path = path
    @engine = engine
    @customer_array = []
    pull_csv
    parse_csv
  end

  def pull_csv
    @contents = CSV.open @customers_path, headers: true, header_converters: :symbol
  end

  def parse_csv
    contents.each do |row| customer_array << Customer.new({
  :id         => row[:id].to_i,
  :first_name => row[:first_name],
  :last_name  => row[:last_name],
  :created_at => Time.parse(row[:created_at]),
  :updated_at => Time.parse(row[:updated_at])
  }, self)
    end
  end

  def all
    customer_array.count
  end

  def find_by_id(find_id)
    customer_array.find do |instance|
      instance.id == find_id
    end
  end

  def find_all_by_first_name(find_fragment)
    customer_array.find_all do |instance|
      instance.first_name.downcase.include?(find_fragment.downcase)
    end
  end
end

# find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
# find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
# The data can be found in data/customers.csv so the instance is created and used like this:
#
# cr = CustomerRepository.new
# cr.from_csv("./data/customers.csv")
# customer = cr.find_by_id(6)
# # => <customer>
