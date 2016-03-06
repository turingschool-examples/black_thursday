require 'time'

class Customer

  def initialize(sales_engine, customer_hash)
    @sales_engine = sales_engine
    @id = customer_hash[:id]
    @first_name = customer_hash[:first_name]
    @last_name = customer_hash[:last_name]
    @created_at = customer_hash[:created_at]
    @updated_at = customer_hash[:updated_at]
  end

  def id
    @id.to_i
  end

  def first_name
    @first_name
  end

  def last_name
    @last_name
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def inspect
    "id: #{id}"
  end
  
end
