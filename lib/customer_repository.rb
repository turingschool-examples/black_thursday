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

  def find_all_by_first_name(first_name)
    @all.find_all do |customer|
      (customer.first_name.downcase).include?(first_name.downcase)
    end

  end

  def find_all_by_last_name(last_name)
    @all.find_all do |customer|
      (customer.last_name.downcase).include?(last_name.downcase)
    end
  end

  def create(hash)
    hash[:id] = @all.last.id + 1
    hash[:created_at] = Time.now.to_s
    hash[:updated_at] = Time.now.to_s

    new_customer = Customer.new(hash)
    @all << new_customer
    new_customer
  end

  def update(id, attributes)
    customer = find_by_id(id)
    customer.first_name = attributes[:first_name]
    customer.last_name = attributes[:last_name]
    customer
  end

  def delete(id)
    deleted_customer = find_by_id(id)

    @all.delete(deleted_customer)
  end
end
