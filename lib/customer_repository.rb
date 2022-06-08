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
end
