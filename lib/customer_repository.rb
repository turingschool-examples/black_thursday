require_relative 'customer'

class CustomerRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def load_customers(csv)
    csv.each do |customer|
      customer[:created_at] = Time.parse(customer[:created_at])
      customer[:updated_at] = Time.parse(customer[:updated_at])
      @all << Customer.new(customer)
    end
  end

  def find_by_id(id)
    @all.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(name)
    @all.select do |customer|
      customer.first_name.downcase.include? name.downcase
    end
  end

  def find_all_by_last_name(name)
    @all.select do |customer|
      customer.last_name.downcase.include? name.downcase
    end
  end

  def create(attributes)
    new_id = @all.max_by do |customer|
      customer.id
    end.id + 1
    attributes[:id] = new_id
    @all << Customer.new(attributes)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    if customer
      customer.update(attributes)
    end
  end

  def delete(id)
    @all.delete_if do |customer|
      customer.id == id
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
