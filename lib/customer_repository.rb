# frozen_string_literal: true

require_relative './customer'
require_relative './repository_helper'

# Customer repository class
class CustomerRepository
  include RepositoryHelper

  def update(id, params)
    return nil unless @repository.key?(id)
    customer = find_by_id(id)
    customer.first_name = params[:first_name] unless params[:first_name].nil?
    customer.last_name  = params[:last_name] unless params[:last_name].nil?
    customer.updated_at = Time.now
  end

  def find_all_by_first_name(first_name)
    all.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  private

  def sub_class
    Customer
  end
end
