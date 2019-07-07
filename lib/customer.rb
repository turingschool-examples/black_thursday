class Customer

  attr_reader :id,
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(customer_data)
    @id = customer_data[:id].to_i
    @first_name = customer_data[:first_name]
    @last_name = customer_data[:last_name]
    @created_at = Time.parse(customer_data[:created_at].to_s)
    @updated_at = Time.parse(customer_data[:updated_at].to_s)
  end
end
