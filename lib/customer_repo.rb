require 'CSV'
require 'pry'
require 'time'
require_relative '../lib/customer'
require_relative '../lib/black_thursday_helper'


class CustomerRepo
  include BlackThursdayHelper

  def initialize(filepath)
    @collections = []
    populate(filepath)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |params|
      @collections << Customer.new(params)
    end
  end

  def find_all_by_first_name(firstname)
    @collections.find_all do |object|
     object.first_name.downcase.include?(firstname.downcase)
    end
  end

  def find_all_by_last_name(lastname)
    @collections.find_all do |object|
     object.last_name.downcase.include?(lastname.downcase)
    end
  end

  def create(customer_params)
    customer = Customer.new(customer_params)
    new_highest_current = object_id_counter.id + 1
    customer.id = new_highest_current
    @collections << customer
    customer
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      object_to_be_updated = find_by_id(id)
      object_to_be_updated.first_name = attributes[:first_name] unless attributes[:first_name].nil?
      object_to_be_updated.last_name = attributes[:last_name] unless attributes[:last_name].nil?
      object_to_be_updated.updated_at = Time.now
    else
      nil
    end
  end
end
