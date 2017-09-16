require 'csv'
require_relative 'customer'
class CustomersRepo

  attr_reader :all_customers, :parent

  def initialize(file, se=nil)
    @all_customers = []
    open_file(file)
    @parent = se
  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      all_customers << Customer.new(row, self)
    end
  end
end
