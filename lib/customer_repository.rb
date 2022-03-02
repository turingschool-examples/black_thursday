# frozen_string_literal: true

class CustomerRepository
  attr_reader :customers

  def initialize(customers)
    @customers = customers
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    @customers.find_all { |customer| customer.first_name.downcase.include?(name.downcase) }
  end

  def find_all_by_last_name(name)
    @customers.find_all { |customer| customer.last_name.downcase.include?(name.downcase) }
  end

  def create(attributes)
    @customers.sort_by(&:id)
    last_id = @customers.last.id
    attributes[:id] = (last_id += 1)
    @customers << Customer.new(attributes)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    attributes.map do |key, v|
      customer.first_name = v if key == :first_name
      customer.last_name = v if key == :last_name
      customer.updated_at = Time.now
    end
  end

  def delete(id)
    @customers.delete(find_by_id(id))
  end

  def inspect
    "#<#{@customers.class} #{@customers.all.size} rows>"
  end
end
