# frozen_string_literal: true

require_relative 'customer'
require_relative 'base_repository'

# customer repo
class CustomerRepository < BaseRepository
  def customers
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| Customer.new(attribute_hash, self)}
  end

  def find_all_by_first_name(name)
    customers.select do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    customers.select do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    customers << Customer.new(attributes, 'parent')
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    found = find_by_id(id)
    if attributes[:first_name]
      found.change_first_name(attributes[:first_name])
    end
    if attributes[:last_name]
      found.change_last_name(attributes[:last_name])
    found.change_updated_at
    end
  end
end
