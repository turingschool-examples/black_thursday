require 'time'

class Merchant

  def initialize(merchant_data)
    @name = merchant_data[:name]
    @id = merchant_data[:id].to_i
    @created_at = Time.parse(merchant_data[:created_at])
    @updated_at = Time.parse(merchant_data[:updated_at])
  end

end
