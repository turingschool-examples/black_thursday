require_relative './repository'
require_relative './customer'

class CustomerRepository < Repository

  def new_record(row)
    Customer.new(row)
  end

  def find_all_by_first_name(customer_name)
    @all.find_all do |customer|
      customer.first_name.upcase.include?(customer_name.upcase)
    end
  end

  def find_all_by_last_name(customer_last_name)
    @all.find_all do |customer|
      customer.last_name.upcase.include?(customer_last_name.upcase)
    end
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @all << new_customer = Customer.new(attributes)
    new_customer
  end

  def update(id, attributes)
    customer = find_by_id(id)
    return customer if customer.nil?
    customer.first_name = attributes[:first_name] unless attributes[:first_name].nil?
    customer.last_name = attributes[:last_name] unless attributes[:last_name].nil?
    customer.updated_at = Time.now
  end


end
