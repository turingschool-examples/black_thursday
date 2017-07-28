class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customers, se)
    @id         = customers[:id]
    @first_name = customers[:first_name].to_s
    @last_name  = customers[:last_name].to_s
    @created_at = Time.parse(customers[:created_at].to_s)
    @updated_at = Time.parse(customers[:updated_at].to_s)
  end

end
