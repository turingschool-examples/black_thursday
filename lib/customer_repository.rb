# frozen_string_literal: true

require_relative 'customer'
# This class holds our transactions and gives us methods to interact with them.
class CustomerRepository
  attr_reader :repository,
              :parent
  def initialize(customers, parent)
    @repository = customers.map do |customer|
      Customer.new(customer, parent)
    end
    @parent = parent
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    @repository.find_all do |customer|
      customer.searchable_first_name.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @repository.find_all do |customer|
      customer.searchable_last_name.include?(name.downcase)
    end
  end

  def create(attributes)
    id_array = @repository.map(&:id)
    new_id = id_array.max + 1
    attributes[:id] = new_id.to_s
    @repository << Customer.new(attributes, self)
  end

  def delete(id)
    customer_to_delete = find_by_id(id)
    @repository.delete(customer_to_delete)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    unchangeable_keys = [:id, :created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if customer.customer_specs.keys.include?(key)
        customer.customer_specs[key] = value
        customer.customer_specs[:updated_at] = Time.now
      end
    end
  end

  def top_spenders
    @repository.map do |customer|
      totals = customer.invoices.map(&:total_successful_invoices)
      [customer, totals.flatten.compact.uniq.inject(:+)]
    end
  end

  def find_all_invoices_by_customer_id
    @parent.find_all_invoices_by_customer_id(id)
  end

  def inspect
    "<#{self.class} #{@repository.size} rows>"
  end
end
