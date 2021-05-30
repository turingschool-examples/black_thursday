class Customer
  attr_reader :id,
              :created_at
  attr_accessor :updated_at,
                :first_name,
                :last_name

  def initialize(customer_info)
    @id = customer_info[:id].to_i
    @first_name = customer_info[:first_name]
    @last_name = customer_info[:last_name]
    @created_at = customer_info[:created_at]
    @updated_at = customer_info[:updated_at]
  end

  def update(attributes)
    @first_name = attributes[:first_name] unless attributes[:first_name].nil?
    @last_name = attributes[:last_name] unless attributes[:last_name].nil?
    @updated_at = Time.now
  end
end
