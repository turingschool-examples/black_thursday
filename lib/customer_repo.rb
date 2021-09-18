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

  def find_all_by_first_name(first_name)
    @all.find_all do |customer|
      customer.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    @all.find_all do |customer|
      customer.last_name == last_name
    end
  end

  def find_highest_id
    max = all.max_by do |customer|
      customer.id
    end
    max.id
  end

  def create(attributes)
    id = find_highest_id + 1
    info = {
      id: id,
      first_name: attributes[:first_name],
      last_name: attributes[:last_name],
      created_at: attributes[:created_at].to_s,
      updated_at: attributes[:updated_at].to_s
      }
    @all << Customer.new(info)
  end
end
