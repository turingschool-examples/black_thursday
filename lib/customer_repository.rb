class CustomerRepository
  attr_reader :customers

  def initialize(filename)
    @customers = create_customers(filename)
  end

  def create_customers(filename)
    FileIo.process_csv(filename, Customer)
  end
end
