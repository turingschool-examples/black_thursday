# frozen_string_literal: true

require_relative './repository'
require_relative './customer'
# holds and retrieves customer data
class CustomerRepository
  include Repository
  attr_reader   :repository

  def initialize(customers)
    create_repository(customers, Customer)
  end

  # def find_all_by_first_name(name)
  #   @repository.values.find_all do |customer|
  #     customer.first_name.downcase.include?(name.downcase)
  #   end
  # end

  # def find_all_by_last_name(name)
  #   @repository.values.find_all do |customer|
  #     customer.last_name.downcase.include?(name.downcase)
  #   end
  # end

  def create(attributes)
    general_create(attributes, Customer)
  end
end
