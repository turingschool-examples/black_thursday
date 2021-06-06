require 'csv'
require_relative '../lib/customer'

class CustomerRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_items(path)
  end

  def create_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      customer = Customer.new(row)
      @all << customer
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def find_by_id(id)
    @all.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name)
    @all.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @all.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    new_id = @all.max_by do |customer|
      customer.id
    end
    attributes[:id] = new_id.id + 1
    customer = Customer.new(attributes)
    @all << customer
    customer
  end

  def update(id, attributes)
    customer = find_by_id(id)
    return customer.update(attributes) unless customer.nil?
  end

  def delete(id)
    delete_item = find_by_id(id)
    @all.delete(delete_item)
  end
end
