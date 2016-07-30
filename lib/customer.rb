class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customer_details, repo = nil)
    @id         = customer_details[:id].to_i
    @first_name = customer_details[:first_name]
    @last_name  = customer_details[:last_name]
    @created_at = format_time(customer_details[:created_at].to_s)
    @updated_at = format_time(customer_details[:updated_at].to_s)
  end

  def format_time(time_string)
    unless time_string == ""
      Time.parse(time_string)
    end
  end

  def merchants
    
  end
end
