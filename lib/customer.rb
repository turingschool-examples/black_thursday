require_relative './time_convert_module'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  include TimeConvert

  def initialize(customer_data)
    @id         = customer_data[:id]
    @first_name = customer_data[:first_name]
    @last_name  = customer_data[:last_name]
    @created_at = time_converter(customer_data[:created_at])
    @updated_at = time_converter(customer_data[:updated_at])
  end

end
