require 'csv'
require_relative '../lib/customer'

class CustomerRepo
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def to_array
    customers = []

    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      headers = row.headers
      customers << row.to_h
    end
    customers.map do | customer |
      Customer.new(customer)
    end
  end

  def find_by_id(id)
    all.find do |customer|
      customer.id == id
    end
  end
end
