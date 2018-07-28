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

  def find_by_id(id)
    return nil unless @customers.key?(id)
    @customers.fetch(id)
  end

  def find_all_by_first_name(first_name)
    customer_list = @customers.find_all do |_, customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end.flatten
    customer_list.keep_if do |element|
      element.is_a?(Customer)
    end
  end

  def find_all_by_last_name(last_name)
    customer_list = @customers.find_all do |_, customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end.flatten
    customer_list.keep_if do |element|
      element.is_a?(Customer)
    end
  end

  # def update(id, params)
  #   return nil unless @customers.key?(id)
  #   customer.first_name = params[:first_name] unless params[:first_name].nil?
  #   customer.last_name  = params[:last_name] unless params[:last_name].nil?
  #   item.updated_at = Time.now
  # end

  def delete(id)
    @customers.delete(id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
