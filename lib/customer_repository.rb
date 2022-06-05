require 'CSV'
require_relative 'customer'

class CustomerRepository
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new(row)
    end
  end

  def find_by_id(id)
    @all.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    @all.find_all { |customer| customer.first_name == first_name }
  end

  def find_all_by_last_name(last_name)
    @all.find_all { |customer| customer.last_name == last_name }
  end

  def create(attributes)
    # require "pry"; binding.pry
    attributes[:id] = @all.max_by { |customer| customer.id }.id + 1
    @all << Customer.new(attributes)
    @all.last
  end

  def update(id, attributes)
    if find_by_id(id)
      find_by_id(id).update(attributes)
    end
  end

  def delete(id)
    @all.delete_if { |customer| customer.id == id }
  end
end
