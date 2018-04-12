require 'csv'
require 'time'
require 'date'
require_relative 'customer'

class CustomerRepository
  attr_reader :path,
              :customers,
              :sales_engine

  def initialize(path, sales_engine)
    @customers = []
    @path = path
    @sales_engine ||= sales_engine
    load_path(path)
  end

  def all
    @customers
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @customers << Customer.new(data, self)
    end
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id.to_i
    end
  end

  def find_all_by_first_name(name)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create_new_id
    @customers.map do |customer|
      customer.id
    end.max + 1
  end

  def create(attribute)
    attribute[:id] = create_new_id
    attribute[:created_at] = Time.now.utc.to_s
    attribute[:updated_at] = Time.now.utc.to_s
    @customers << Customer.new(attribute, self)
  end

  def update(id, attribute)
    return nil if find_by_id(id).nil?
    to_update = find_by_id(id)
    to_update.update_updated_time
    to_update.update_first_name(attribute[:first_name]) if attribute[:first_name]
    to_update.update_last_name(attribute[:last_name]) if attribute[:last_name]
  end

  def delete(id)
    @customers.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
