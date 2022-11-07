class CustomerRepository

  def initialize(customers, engine)
    @customers  = create_customers(customers)
    @engine     = engine
  end

  ######################################
  def all
    @customers
  end

  def find_by_id(id)
    if !a_valid_id?(id)
      return nil
    else
      @customers.find do |customer|
        customer.id == id
      end
    end
  end

  def a_valid_id?(id)
    @customers.any? do |customer| customer.id == id
    end 
  end
  
  def find_all_by_first_name(string)
    @customers.find_all do |customer| 
      customer.first_name.downcase.include?(string.downcase)
    end
  end
  
  def find_all_by_last_name(string)
    @customers.find_all do |customer| 
      customer.last_name.downcase.include?(string.downcase)
    end
  end

  def create(attribute)
    new_id = @customers.last.id + 1
    @customers << Customer.new({:id => new_id, 
                                :first_name => attribute[:first_name],
                                :last_name => attribute[:last_name],
                                :created_at => attribute[:created_at].to_s,
                                :updated_at => attribute[:updated_at].to_s
                                }, self)
  end

  def update(id, attributes)
    @customers.find do |customer|
      customer.update(attributes) if customer.id == id
    end
  end

  def delete(id)
    @customers.delete(find_by_id(id))
  end

  def create_customers(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_customer_object(contents)
  end
  
  def make_customer_object(contents)
    contents.map do |row|
      customer = {
              :id => row[:id].to_i, 
              :first_name => row[:first_name].to_s,
              :last_name => row[:last_name].to_s,  
              :created_at => row[:created_at],
              :updated_at => row[:updated_at]
            }
      Customer.new(customer, self)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end