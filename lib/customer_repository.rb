require 'csv'
require_relative 'customer'

class CustomerRepository

  attr_reader :all

# says all is a method that returns an array of all known instances
#but since everyone set it up as an instance var, I will do that too.

  def initialize(path)
    @all  = generate(path)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def generate(path)
    rows = CSV.read(path, headers: true, header_converters: :symbol)

    rows.map do |row|
      Customer.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |customer|
      id == customer.id
    end
  end

  def find_all_by_first_name

  end

  def find_all_by_last_name

  end
end
