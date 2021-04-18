class CustomerRepository
  attr_reader :customers

  def initialize(filename)
    @customers = create_customers(filename)
  end

  def create_customers(filename)
    FileIo.process_csv(filename, Customer)
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name)
    @customers.select do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    @customers.select do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    new_customer = Customer.new(attributes)
    @customers << new_customer
  end
end
