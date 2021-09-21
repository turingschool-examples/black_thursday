# frozen_string_literal: true

require 'csv'
require_relative 'customer'
require_relative 'csv_readable'

class CustomerRepository
  include CSV_readable

  attr_reader :all

  def initialize(path)
    @all  = generate(path)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def generate(path)
    rows = read_csv(path)

    rows.map do |row|
      Customer.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |customer|
      id == customer.id
    end
  end

  def find_all_by_first_name(first_name)
    @all.find_all do |customer|
      (customer.first_name.downcase).include?(first_name.downcase)
    end

  end

  def find_all_by_last_name(last_name)
    @all.find_all do |customer|
      (customer.last_name.downcase).include?(last_name.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s

    new_customer = Customer.new(attributes)
    @all << new_customer
    new_customer
  end

  def update(id, attributes)
    customer = find_by_id(id)
    if attributes[:first_name] != nil
      customer.update_fname(attributes[:first_name])
    end
    if attributes[:last_name] != nil
      customer.update_lname(attributes[:last_name])
    end
    if customer != nil
      customer.update_updated_at
    end
    customer
  end

  def delete(id)
    deleted_customer = find_by_id(id)

    @all.delete(deleted_customer)
  end
end
