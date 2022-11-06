require 'time'
class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = time_converter(attributes[:created_at])
    @updated_at = time_converter(attributes[:updated_at])
  end

  def time_converter(attributes)
    return unless attributes
    Time.parse(attributes)
  end
end