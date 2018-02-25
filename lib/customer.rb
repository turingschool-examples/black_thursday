require 'time'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :unit_price,
              :created_at,
              :updated_at,
              :customer_repo

  def initialize(data, parent = nil)
    @id             = data[:id].to_i
    @first_name     = data[:first_name]
    @last_name      = data[:last_name]
    @created_at     = Time.parse(data[:created_at])
    @updated_at     = Time.parse(data[:updated_at])
    @customer_repo  = parent
  end

end
