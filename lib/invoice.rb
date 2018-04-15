require_relative 'elementals'

# invoice class
class Invoice
  include Elementals

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at

  attr_accessor :status,
                :updated_at

  def initialize(attrs)
    @id          = attrs[:id].to_i
    @customer_id = attrs[:customer_id].to_i
    @merchant_id = attrs[:merchant_id].to_i
    @status      = attrs[:status].to_sym
    @created_at  = format_time(attrs[:created_at])
    @updated_at  = format_time(attrs[:updated_at])
  end
end
