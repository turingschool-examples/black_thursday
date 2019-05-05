# frozen_string_literal: true

require_relative 'customer'
require_relative 'repository_helper'
# This class holds our transactions and gives us methods to interact with them.
class CustomerRepository
  include RepositoryHelper
  attr_reader :repository,
              :parent,
              :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
  def initialize(customers, parent)
    @repository = customers.map do |customer|
      Customer.new(customer, parent)
    end
    @parent = parent
    build_hash_tables
  end

  def build_hash_tables
    @id = @repository.group_by(&:id)
    @first_name = @repository.group_by(&:first_name)
    @last_name = @repository.group_by(&:last_name)
    @created_at = @repository.group_by(&:created_at)
    @updated_at = @repository.group_by(&:updated_at)
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
    attributes[:id] = (@id.keys.sort.last + 1)
    @repository << Customer.new(attributes, self)
    build_hash_tables
  end

  def delete(id)
    customer_to_delete = find_by_id(id)
    @repository.delete(customer_to_delete)
    build_hash_tables
  end

  def update(id, attributes)
    customer = find_by_id(id)
    unchangeable_keys = %i[id created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if customer.customer_specs.keys.include?(key)
        customer.customer_specs[key] = value
        customer.customer_specs[:updated_at] = Time.now
      end
    end
    build_hash_tables
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
