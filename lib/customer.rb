class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customer, parent)
    @id = customer[:id].to_i
    @first_name = customer[:first_name]
    @last_name = customer[:last_name]
    @created_at = Time.parse(customer[:created_at])
    @updated_at = Time.parse(customer[:updated_at])
    @parent = parent
  end

end
