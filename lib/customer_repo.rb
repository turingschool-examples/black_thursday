require_relative 'customer'

class CustomerRepo 
  attr_accessor :customers

  def initialize(customers)
    @customers = customers
    change_customer_hash_to_object
  end
  
  def change_customer_hash_to_object
    customer_array = []
    @customers.each do |customer|
      customer_array << Customer.new(customer)
    end
    @customers = customer_array
  end
  
  def all 
    @customers
  end
  
  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end 
  
  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end
  
  def find_all_by_last_name(last_name)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end
  
  def create(attributes)
    customer_new = Customer.new(attributes)
    max_customer_id = @customers.max_by do |customer|
      customer.id
    end
    new_max_id = max_customer_id.id + 1
    customer_new.id = new_max_id
    @customers << customer_new
    return customer_new 
  end 
  
  def update(id, attributes)
    customer_to_change = find_by_id(id)
    return if customer_to_change.nil?
    if attributes[:first_name]
      customer_to_change.first_name = attributes[:first_name]
    end
    if attributes[:last_name]
      customer_to_change.last_name = attributes[:last_name]
    end
    customer_to_change.updated_at = Time.now
    customer_to_change 
  end
  
  def delete(id)
    customer_to_delete = find_by_id(id)
    @customers.delete(customer_to_delete)
  end
  
  
end
  
  
