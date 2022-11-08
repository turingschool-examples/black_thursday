class Customer 
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(customer)
    @id = customer[:id]
    @first_name = customer[:first_name]
    @last_name = customer[:last_name]
    @created_at = customer[:created_at]
    @updated_at = customer[:updated_at]
  end 

  def update_first_name(first_name)
    @first_name = first_name
  end

  def update_last_name(last_name)
    @last_name = last_name
  end 

  def update_time
    @updated_at = Time.now
  end 
end 