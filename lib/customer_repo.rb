require_relative 'customer'
require_relative 'sales_engine'
require 'csv'
class CustomerRepository
  attr_reader :path,
              :engine,
              :customers

  def initialize(path, engine)
    @path = path
    @engine = engine
    @customers = []
    read_customers
  end

  def read_customers
    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      @customers << Customer.new(row, self)
    end
    @customers
  end

  def all
    @customers
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_last_name(last_name)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def highest_id
    @customers.max_by do |customer|
      customer.id
    end
  end

  def create(attributes)
    attributes[:created_at] = Time.new.to_s
    attributes[:updated_at] = Time.new.to_s
    attributes[:id] = highest_id.id + 1
    @customers << Customer.new(attributes, self)
  end

  def update(id, attributes)
    update = find_by_id(id)
    return nil if update.nil?

    update.first_name = attributes[:first_name] if attributes.has_key?(:first_name)
    update.last_name  = attributes[:last_name] if attributes.has_key?(:last_name)
    update.updated_at = Time.now
  end

  def delete(id)
    delete = find_by_id(id)
    @customers.delete(delete)
  end
end
