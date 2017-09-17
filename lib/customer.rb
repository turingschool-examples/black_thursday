require 'csv'
require 'time'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(customer, repo = nil)
    @id = customer[:id].to_i
    @first_name = customer[:first_name].to_s
    @last_name = customer[:last_name].to_s
    @created_at = Time.parse(customer[:created_at].to_s)
    @updated_at = Time.parse(customer[:updated_at].to_s)
    @parent = repo
  end

  def merchants
    parent.customer_merchants(self.id)
  end
end
