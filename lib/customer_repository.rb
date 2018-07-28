# frozen_string_literal: true

require_relative './customer'

# Customer repository class
class CustomerRepository
  def initialize
    @customers = {}
  end

  def populate(data)
    data.map do |row|
      create(row)
    end
  end

  def create(params)
    params[:id] = @customers.max[0] + 1 if params[:id].nil?

    Customer.new(params).tap do |customer|
      @customers[params[:id].to_i] = customer
    end
  end

  def all
    customer_list = @customers.to_a.flatten
    customer_list.keep_if do |element|
      element.is_a?(Customer)
    end
  end




end
