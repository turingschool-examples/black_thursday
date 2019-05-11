require_relative '../elementals/customer'
require_relative 'repository'

# customer_repository class
class CustomerRepository < Repository
  attr_reader :customers

  def initialize(customers_data)
    @customers = create_index(Customer, customers_data)
    super(customers, Customer)
  end

  def find_all_by_first_name(first_name_frag)
    @customers.values.find_all do |customer|
      customer.first_name.downcase.include?(first_name_frag.downcase)
    end
  end

  def find_all_by_last_name(last_name_frag)
    @customers.values.find_all do |customer|
      customer.last_name.downcase.include?(last_name_frag.downcase)
    end
  end

  def update(id, attrs)
    return unless @customers[id]
    @customers[id].first_name = attrs[:first_name] if attrs[:first_name]
    @customers[id].last_name = attrs[:last_name] if attrs[:last_name]
    @customers[id].updated_at = Time.now
  end

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end
end
