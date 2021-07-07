require_relative 'repository'
require_relative 'customer'

class CustomerRepository
  include Repository

  def initialize
    @customers = []
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

  def all
    @customers
  end

  def create_with_id(attributes)
    @customers << Customer.new(attributes)
  end

  def child_class
    Customer
  end

  def create(attributes)
    all << child_class.create(attributes)
  end

  def find_all_by_first_name(name)
    all.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    all.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def update(id, attributes)
    customer = find_by_id(id)
    return nil if customer.nil?
    customer.first_name = attributes[:first_name] unless attributes[:first_name].nil?
    customer.last_name = attributes[:last_name] unless attributes[:last_name].nil?
    customer.updated_at = Time.now
  end

end
