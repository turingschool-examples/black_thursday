require_relative 'customer'
require 'csv'

class CustomerRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def from_csv(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      all << Customer.new(row)
    end
  end

  def find_by_id(id)
    @all.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    @all.find_all { |customer| customer.first_name == name }
  end

  def find_all_by_last_name(name)
    @all.find_all { |customer| customer.last_name == name }    
  end

end
