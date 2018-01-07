require "time"
require "bigdecimal"

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repo

  def initialize(row, customer_repo)
    @id            = row[:id]
    @first_name    = row[:first_name]
    @last_name     = row[:last_name]
    @created_at    = Time.parse(row[:created_at])
    @updated_at    = Time.parse(row[:updated_at])
    @customer_repo = customer_repo
  end
end
