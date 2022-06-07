class Customer
  attr_reader :id,
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(customer)
    @id = customer[:id]
    @first_name = customer[:first_name]
    @last_name = customer[:last_name]
    @created_at = customer[:created_at]
    @updated_at = customer[:updated_at]
  end
end
