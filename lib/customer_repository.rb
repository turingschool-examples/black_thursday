class CustomerRepository 

  def initialize(customers)
    @customers = customers
  end 

  def all
    @customers
  end 

  def find_by_id(id)
    @customers.find {|customer| customer.id == id}
  end 

  def find_all_by_first_name(first_name)
    @customers.find_all {|customer| customer.first_name == first_name}
  end 

  def find_all_by_last_name(last_name)
    @customers.find_all {|customer| customer.last_name == last_name}
  end 

  def create(attributes)
    ids = @customers.map { |customer| customer.id}
    attributes[:id] = ids.max + 1
    new_customer = Customer.new(attributes)
    @customers.push(new_customer)
    new_customer
  end 

  def all_ids
    ids = @customers.map { |customer| customer.id}
  end 

  def update(id, attributes)
    if all_ids.include?(id)
      updated_customer = find_by_id(id)
        if updated_customer.first_name != nil || updated_customer.last_name != nil
           updated_customer.update_first_name(attributes[:first_name])
           updated_customer.update_last_name(attributes[:last_name])
           updated_customer.update_time
        end
        updated_customer
    end 
  end
end 