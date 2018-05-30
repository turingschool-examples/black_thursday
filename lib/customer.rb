require 'time'

class Customer
  attr_reader :id,
              :created_at

attr_accessor :first_name,
              :last_name,
              :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
  end
end
