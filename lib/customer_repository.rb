# frozen_string_literal: true

require_relative './repository'
require_relative './customer'
# holds and retrieves customer data
class CustomerRepository
  include Repository
  attr_reader :repository

  def initialize(customers)
    create_repository(customers, Customer)
  end

  def create(attributes)
    general_create(attributes, Customer)
  end
end
