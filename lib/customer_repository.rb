require 'csv'
require_relative 'customer'
require_relative 'inspector'

class CustomerRepository
  include Inspector
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new(row)
    end
  end

  def find_all_by_first_name(first_name_search)
    @all.find_all do |customer|
      customer.first_name.downcase.include?(first_name_search.downcase)
    end
  end

  def find_all_by_last_name(last_name_search)
    @all.find_all do |customer|
      customer.last_name.downcase.include?(last_name_search.downcase)
    end
  end

  def update(customer_id_search, attributes)
    @all.find do |customer|
      if customer.id == customer_id_search
        customer.first_name = attributes[:first_name] unless attributes[:first_name].nil?
        customer.last_name = attributes[:last_name] unless attributes[:last_name].nil?
        customer.updated_at = Time.now
      end
    end
  end
end
