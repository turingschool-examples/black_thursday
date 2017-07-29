require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
  def initialize(hash, sales_engine)
    @sales_engine = sales_engine
    @id           = hash[:id]
    @first_name   = hash[:first_name]
    @last_name    = hash[:last_name]
    @created_at   = Time.parse(hash[:created_at]) if hash[:created_at]
    @updated_at   = Time.parse(hash[:updated_at]) if hash[:updated_at]
  end
end
