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
  end
# def create(params)
#   params[:id] = @merchants.max[0] + 1 if params[:id].nil?
#
#   Merchant.new(params).tap do |merchant|
#     @merchants[params[:id].to_i] = merchant
#   end
# end

end
