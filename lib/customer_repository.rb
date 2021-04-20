require_relative 'sales_engine'
require_relative 'customer'

class CustomerRepository
  attr_reader :customers

  def initialize(path, engine)
    @customers = []
    @engine = engine
    make_items(path)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def make_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @customers << Customer.new(row, self)
    end
  end

  def all
    @customers
  end

  def find_by_id(id)
    RepoBrain.find_by_id(id, 'id', @customers)
  end

  def find_all_by_first_name(fragment)
    RepoBrain.find_all_by_partial_string(fragment, 'first_name', @customers)
  end

  def find_all_by_last_name(fragment)
    RepoBrain.find_all_by_partial_string(fragment, 'last_name', @customers)
  end

  def generate_new_id
    RepoBrain.generate_new_id(@customers)
  end

  def create(attributes)
    attributes[:id] = generate_new_id
    @customers << Customer.new(attributes, self)
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      customer_to_update = find_by_id(id)
      customer_to_update.update(attributes)
    end
  end

  def delete(id)
    customers.delete(find_by_id(id))
  end
end