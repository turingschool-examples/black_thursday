require 'time'

class Invoice

attr_reader :id,
            :customer_id,
            :merchant_id,
            :status,
            :created_at,
            :updated_at,
            :repository

  def initialize (row, parent)
    @id           = row[:id].to_i
    @customer_id  = row[:customer_id]
    @merchant_id  = row[:merchant_id]
    @status       = row[:status]
    @created_at   = Time.parse(row[:created_at])
    @updated_at   = Time.parse(row[:updated_at])
    @repository   = parent
  end

  def merchant
    repository.find_merchant(self.merchant_id)
  end

end
