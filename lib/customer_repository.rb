class CustomerRepository
  attr_reader :customers

  def initialize(customers)
    @customers = customers
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find {|customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    @customers.find_all { |customer| customer.first_name.downcase.include?(name.downcase) }
  end

  def find_all_by_last_name(name)
    @customers.find_all { |customer| customer.last_name.downcase.include?(name.downcase) }
  end
end
