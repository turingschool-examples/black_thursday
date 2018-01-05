require 'csv'

class CustomerRepository
  def initialize
    @customers = []
  end

  def from_csv(file_path)
    customer_data = CSV.open file_path, headers: true, header_converters: :symbol, converters: :numeric
    parse(customer_data)
  end

  def parse(customer_data)
    customer_data.each do |row|
      
end
