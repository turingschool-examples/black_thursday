class CustomerRepository

  attr_reader :customers, :sales_engine

  def initialize(customers, sales_engine = nil)
    @customers     = customers
    @sales_engine  = sales_engine
  end

  def all
    customers
  end

  def find_by_id(id)
    customers.find { |row| row.id == id }
  end

  def find_by_first_name(first_name)
    customers.select { |row| row.first_name == first_name }
  end

  def find_by_last_name(last_name)
    customers.select { |row| row.last_name == last_name }
  end
end
