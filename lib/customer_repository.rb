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
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(fragment)
    @customers.find_all do |customer|
      name = customer.first_name.downcase
      name.include?(fragment.downcase)
    end
  end

  def find_all_by_last_name(fragment)
    @customers.find_all do |customer|
      name = customer.last_name.downcase
      name.include?(fragment.downcase)
    end
  end

   def generate_new_id
    highest_id_item = @customers.max_by do |customer|
      customer.id
    end
    new_id = highest_id_item.id + 1
  end

  def create(attributes)
    attributes[:id] = generate_new_id
    @customers << Customer.new(attributes, self)
  end

  def update(id, attributes)
      if find_by_id(id) != nil
      customer_to_update = find_by_id(id)
      customer_to_update.update_name(attributes)
      customer_to_update.update_time_stamp
    end
  end

  def delete(id)
    customers.delete(find_by_id(id))
  end
end