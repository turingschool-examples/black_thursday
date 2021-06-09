require_relative 'inspectable'

class CustomerRepository
  include Inspectable

  attr_reader :sales_engine, :file_path, :all

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
    @all = generate
  end

  def generate
    info = CSV.open(@file_path.to_s, headers: true, header_converters: :symbol)
    info.map do |row|
      Customer.new(row, self)
    end
  end
end