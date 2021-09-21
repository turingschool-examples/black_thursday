require 'csv'
require_relative './sales_engine'
require_relative './customer'

class CustomerRepository

  def initialize(data)
    @customers = data
  end

  def all
    @customers
  end

  def find_by_id(id)
    customer_id = nil
    @customers.select do |customer|
      if customer.id == id
        customer_id = customer
      end
    end
    customer_id
  end

  def find_all_by_first_name(name)
    @customers.find_all do |customer|
      customer if customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @customers.find_all do |customer|
      customer if customer.last_name.downcase.include?(name.downcase)
    end
  end

  def highest_id
    new = @customers.max_by(&:id)
    new.id + 1
  end

  def create(attributes)
    new_customer = Customer.new([highest_id, attributes[:first_name].downcase.capitalize, attributes[:last_name].downcase.capitalize, Time.now.strftime('%Y-%m-%d'), Time.now.strftime('%Y-%m-%d')])
    @customers << new_customer
  end

  def update(id, attribute)
    @customers.map do |customer|
      if customer.id == id
        customer.first_name = attribute[:first_name] if attribute.keys.include?(:first_name)
        customer.last_name = attribute[:last_name] if attribute.keys.include?(:last_name)
        customer.updated_at = Time.now
      end
    end
  end

  def delete(id)
    trash = @customers.find do |customer|
      customer.id == id
    end
    @customers.delete(trash)
  end
end
