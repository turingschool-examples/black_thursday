require_relative '../lib/customer'
require_relative '../lib/repository'

class CustomerRepository < Repository

  def initialize(path)
    super(path, Customer)
  end

  def update(id, attributes)
    target = find_by_id(id)
    if target != nil
      target.first_name = attributes[:first_name] if attributes[:first_name] != nil
      target.last_name = attributes[:last_name] if attributes[:last_name] != nil
      target.updated_at = Time.now
    end
  end

  def find_all_by_first_name(first_name)
    @array_of_objects.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @array_of_objects.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end
end
