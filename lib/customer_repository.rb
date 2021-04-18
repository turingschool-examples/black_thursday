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
      customer.first_name.include?(name)
    end
  end
end
