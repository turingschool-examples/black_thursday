class Customer
  attr_reader :id,
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(customer_hash)
    @id = customer_hash[:id].to_i
    @first_name = customer_hash[:first_name]
    @last_name = customer_hash[:last_name]
    @created_at = Time.parse(customer_hash[:created_at])
    @updated_at = Time.parse(customer_hash[:updated_at])
  end
end
