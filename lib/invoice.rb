require 'time'

class Invoice
  attr_reader   :customer_id,
                :merchant_id,
                :created_at

  attr_accessor :id,
                :status,
                :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @customer_id = hash[:customer_id].to_i
    @merchant_id = hash[:merchant_id].to_i
    @status = hash[:status].to_s
    @created_at = if hash[:created_at].class == String
                    Time.parse(hash[:created_at])
                  else
                    Time.now
                  end
    @updated_at = if hash[:updated_at].class == String
                    Time.parse(hash[:updated_at])
                  else
                    Time.now
                  end
  end

end
