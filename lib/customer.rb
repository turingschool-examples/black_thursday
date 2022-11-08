# frozen_string_literal: true

require 'timeable'

# Customer class, holds id, first and last name and create/update times
class Customer
  include Timeable
  attr_reader :id,
              :first_name,
              :last_name,
              :created_time,
              :updated_time

  def initialize(customer_data, repo)
    @customer_repo = repo
    @id = customer_data[:id].to_i
    @first_name = customer_data[:first_name]
    @last_name = customer_data[:last_name]
    @created_time = customer_data[:created_at]
    @updated_time = customer_data[:updated_at]
  end

  def update(attributes)
    @first_name = attributes[:first_name] unless attributes[:first_name].nil?
    @last_name = attributes[:last_name] unless attributes[:last_name].nil?
    @updated_time = Time.now
  end
end
