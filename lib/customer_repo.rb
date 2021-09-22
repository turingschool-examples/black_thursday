require 'csv'
require_relative './sales_engine'
require_relative './customer'
require_relative './inspectable'

class CustomerRepository
  include Inspectable
  def initialize(data)
    @customers = data
  end

  def all
    @customers
  end

  def find_by_id(id)
    customer_id = nil
    @customers.select do |customer|
      customer_id = customer if customer.id == id
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
    new_customer = Customer.new([highest_id,
                                 attributes[:first_name].downcase.capitalize, attributes[:last_name].downcase.capitalize, Time.now.strftime('%Y-%m-%d'), Time.now.strftime('%Y-%m-%d')])
    @customers << new_customer
  end

  def update(id, attribute)
    @customers.map do |customer|
      next unless customer.id == id

      if attribute.keys.include?(:first_name)
        customer.first_name = attribute[:first_name]
      end
      if attribute.keys.include?(:last_name)
        customer.last_name = attribute[:last_name]
      end
      customer.updated_at = Time.now
    end
  end

  def delete(id)
    trash = @customers.find do |customer|
      customer.id == id
    end
    @customers.delete(trash)
  end
end
