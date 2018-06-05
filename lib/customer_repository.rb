require_relative 'repository'
require_relative 'customer'

class CustomerRepository
  include Repository

  def initialize(loaded_file)
    @repository = loaded_file.map { |customer| Customer.new(customer)}
  end

  def find_all_by_first_name(fragment)
    all.find_all { |customer| customer.first_name.upcase.include?(fragment.upcase) }
  end

  def find_all_by_last_name(fragment)
    all.find_all { |customer| customer.last_name.upcase.include?(fragment.upcase) }
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @repository.push(Customer.new(attributes))
  end

  def update(id, attributes)
    customer = find_by_id(id)
    return customer if customer.nil?
    customer.update_first_name(attributes[:first_name]) unless attributes[:first_name].nil?
    customer.update_last_name(attributes[:last_name]) unless attributes[:last_name].nil?
    customer.new_update_time(Time.now.utc) unless attributes.empty?
  end
end
