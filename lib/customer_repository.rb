require_relative '../lib/customer'
require_relative 'repository'

# customer_repository class
class CustomerRepository < Repository
  attr_reader :customers

  def initialize(csv_parsed_array)
    csv_parsed_array.shift
    attributes = csv_parsed_array.map do |customer|
      { id: customer[0].to_i,
        first_name: customer[1],
        last_name: customer[2],
        created_at: customer[3],
        updated_at: customer[4] }
    end
    @customers = create_index(Customer, attributes)
    super(customers, Customer)
  end

  def find_all_by_first_name(first_name)
    @customers.values.map do |customer|
      customer if customer.first_name == first_name
    end.compact
  end

  def find_all_by_last_name(last_name)
    @customers.values.map do |customer|
      customer if customer.last_name == last_name
    end.compact
  end

  def update(id, attributes)
    if @customers[id]
      @customers[id].first_name = attributes[:first_name] if attributes[:first_name]
      @customers[id].last_name = attributes[:last_name] if attributes[:last_name]
      @customers[id].updated_at = Time.now
    end
  end
end
