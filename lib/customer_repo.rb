require_relative 'customer'

class CustomerRepository
  attr_reader :customers, :engine

  def initialize(csv_data, engine)
    @engine    = engine
    @customers = csv_data
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    customers
  end

  def find_by_id(id)
    customers.detect { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    customers.select { |customer| customer.first_name == first_name } || []
  end

  def find_all_by_last_name(last_name)
    customers.select { |customer| customer.last_name == last_name } || []
  end

end
