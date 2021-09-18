class CustomerRepository
  attr_reader :all

  def initialize(customer_data)
    @all = fill_customers(customer_data)
  end

  def fill_customers(customer_data)
    all_customers = CSV.parse(File.read(customer_data))
    categories = all_customers.shift
    all_customers.map do |customer|
      individual_customer = {}
      categories.zip(customer) do |category, attribute|
        individual_customer[category.to_sym] = attribute
      end
      Customer.new(individual_customer)
    end
  end

  def find_by_id(id)
    all.find { |customer| customer.id.to_i == id.to_i }
  end
end
