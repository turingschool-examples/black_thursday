require 'time'

# customer class
class Customer
  attr_reader :id,
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  # def initialize(customer_hash = Hash.new(0))
  #   @id = customer_hash[:id].to_i
  #   @first_name = customer_hash[:first_name]
  #   @last_name = customer_hash[:last_name]
  #   @created_at  = customer_hash[:created_at]
  #   @updated_at  = customer_hash[:updated_at]
  # end

  def initialize(attrs)
    @id = attrs[:id].to_i
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @created_at  = format_time(attrs[:created_at])
    @updated_at  = format_time(attrs[:updated_at])
  end
  
  def format_time(time_value)
    if time_value.class == Time
      return time_value
    else
      return Time.parse(time_value)
    end
  end
end
