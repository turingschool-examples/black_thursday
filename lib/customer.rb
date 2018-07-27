require 'time'
require_relative 'repository'

class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(information)
    @id         = information[:id].to_i
    @first_name = information[:first_name]
    @last_name  = information[:last_name]
    @created_at = Time.parse(information[:created_at].to_s)
    @updated_at = Time.parse(information[:updated_at].to_s)
  end
end
