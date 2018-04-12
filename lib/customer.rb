# customer class
class Customer
  attr_reader :id,
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(customer_hash = Hash.new(0))
    @id = customer_hash[:id].to_i
    @first_name = customer_hash[:first_name]
    @last_name = customer_hash[:last_name]
    @created_at  = customer_hash[:created_at]
    @updated_at  = customer_hash[:updated_at]
  end
end
