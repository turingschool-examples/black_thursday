class Customer
  attr_reader :id, :first_name, :last_name,
  :sales_engine, :customers

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end

  def add_new(data, sales_engine)
    customers << Customer.new(data, sales_engine)
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end


end
