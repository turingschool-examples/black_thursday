require_relative './time_convert_module'

class Merchant
  attr_reader :id, :created_at
  attr_accessor :name

  include TimeConvert

  def initialize(merchant_data)
    @id = merchant_data[:id].to_i
    @name = merchant_data[:name]
    @created_at = time_converter(merchant_data[:created_at])
    @updated_at = time_converter(merchant_data[:updated_at])
  end

end
