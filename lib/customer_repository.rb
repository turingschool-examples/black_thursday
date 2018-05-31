require_relative 'customer'
class CustomerRepository

  def initialize
    @customers = []
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    @customers.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @customers.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def create(attributes)
    if attributes[:id].nil?
      id = @customers[-1].id + 1
    else
      id = attributes[:id]
    end
    new_customer = Customer.new({id: id,
                      first_name: attributes[:first_name],
                      last_name: attributes[:last_name],
                      created_at: attributes[:created_at].to_s,
                      updated_at: attributes[:updated_at].to_s})
    @customers << new_customer
    return new_customer
  end

  def update(id, attributes)
    if find_by_id(id).nil?
      return
    else
      updated_customer = find_by_id(id)
    end
    updated_customer.first_name ||= attributes[:first_name]
    updated_customer.last_name = attributes[:last_name]
    updated_customer.updated_at = Time.now
  end

  def delete(id)
    deleted_customer = find_by_id(id)
    @customers.delete(deleted_customer)
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
