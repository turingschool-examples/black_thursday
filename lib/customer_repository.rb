require 'csv'
require_relative 'customer'

class CustomerRepository

  attr_reader :all

  def initialize(file_path, parent = nil)
    @parent = parent
    @all = []
    populate_customers(file_path)
  end

  def populate_customers(file_path)
    CSV.foreach(file_path, row_sep: :auto, headers: true) do |line|
      self.all << Customer.new(line, self)
    end
  end

  def find_by_id(id)
    @all.find do |customer|
      customer.id == id
    end
  end

end
