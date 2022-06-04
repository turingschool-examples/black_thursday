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
end
