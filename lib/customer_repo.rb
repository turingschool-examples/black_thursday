require_relative 'customer'

class CustomerRepository
  attr_reader :customers, :sales_engine
  def initialize(customer_file, sales_engine)
    @customers = read_customer_file(customer_file)
    @sales_engine = sales_engine
  end

  def read_customer_file(customer_file)
    customer_list = []
    CSV.foreach(customer_file,headers: true,header_converters: :symbol) do |row|
      customer_info = {}
      customer_info[:id] = row[:id]
      customer_info[:first_name] = row[:first_name]
      customer_info[:last_name] = row[:last_name]
      customer_info[:created_at] = row[:created_at]
      customer_info[:updated_at] = row[:updated_at]
      customer_list << Customer.new(customer_info, self)
    end
    customer_list
  end

  def all
    customers
  end

  def find_by_id(id)
    customers.find {|customer| customer.id == id}
  end

  def find_all_by_first_name(first_name)
    customers.find {|customer| customer.first_name.downcase == first_name.downcase}
  end

  def find_all_by_last_name
    customers.find {|customer| customer.last_name.downcase == last_name.downcase}
  end

  def find_by_created_at(created_at)
    customers.find {|customer| customer.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    customers.find {|customer| customer.updated_at == updated_at}
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
