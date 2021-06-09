require_relative 'inspectable'

class CustomerRepository
  include Inspectable

  attr_reader :sales_engine, :file_path

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
  end
end