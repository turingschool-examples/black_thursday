require 'time'

class Customer
  attr_reader :id,
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(customer)
    @id = customer[:id].to_i
    @first_name = customer[:first_name]
    @last_name = customer[:last_name]
    @created_at = Time.parse(customer[:created_at].to_s)
    @updated_at = Time.parse(customer[:updated_at].to_s)
  end
end
