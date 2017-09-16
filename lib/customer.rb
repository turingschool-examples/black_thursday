require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(info, customer_repository='')
    @id = info[:id].to_i
    @first_name = info[:first_name]
    @last_name = info[:last_name]
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @customer_repository = customer_repository
  end

end
