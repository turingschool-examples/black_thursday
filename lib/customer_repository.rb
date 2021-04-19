class CustomerRepository
  attr_reader :customers

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

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

  def find_max_id
    @customers.max_by(&:id).id
  end

  def create(attributes)
    new_customer = Customer.new(attributes)
    new_customer.update_id(find_max_id + 1)
    @customers << new_customer
  end

  def update(id, attributes)
    customer = find_by_id(id)
    unless customer.nil?
      customer.update_first_name(attributes[:first_name])
      customer.update_last_name(attributes[:last_name])
      customer.update_time
    end
  end

  def delete(id)
    customer = find_by_id(id)
    @customers.delete(customer)
  end
end
