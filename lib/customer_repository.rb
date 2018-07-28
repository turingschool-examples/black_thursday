# frozen_string_literal: true

require_relative './customer'

# Customer repository class
class CustomerRepository
  def initialize
    @customer = {}
  end

  def populate(data)
    data.map do |row|
      create(row)
    end
  end

  def create(params)
    params[:id] = @customer.max[0] + 1 if params[:id].nil?

    Customer.new(params).tap do |customer|
      @customer[params[:id].to_i] = customer
    end
  end


end
