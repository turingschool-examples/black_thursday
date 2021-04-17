require_relative '../lib/customer'
require_relative '../lib/repository'

class CustomerRepository < Repository

  def initialize(path)
    super(path)
    @array_of_objects = create_customers(@parsed_csv_data)
  end

  def create_customers(parsed_csv_data)
    parsed_csv_data.map do |customer|
      Customer.new(customer)
    end
  end

end
