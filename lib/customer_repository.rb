# frozen_string_literal: true
require_relative 'customer'
require_relative 'base_repository'

# customer repo
class CustomerRepository < BaseRepository
  def customers
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| Merchant.new(attribute_hash, self)}
  end

  def find_all_by_first_name(name)
    found = customers.map do |customer|
      if customer.first_name.downcase.include?(name.downcase)
        customer
      end
    end
    found.compact
  end

  def find_all_by_last_name(name)
    found = customers.map do |customer|
      if customer.last_name.downcase.include?(name.downcase)
        customer
      end
    end
    found.compact
  end

  def find_highest_id
    merchants.map { |merchant| merchant.id }.max
  end

  def create_new_id
    find_highest_id + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now
    attributes[:updated_at] = Time.now
    merchants << Merchant.new(attributes, 'parent')
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    found = find_by_id(id)
    found.change_name(attributes[:name])
    found.change_updated_at
  end
