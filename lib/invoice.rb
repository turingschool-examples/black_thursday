# frozen_string_literal: false

require 'time'
# Responsible for creating of Invoice objects
class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :created_at
  attr_accessor :status,
                :updated_at

  def initialize(args)
    @id           = args[:id].to_i
    @customer_id  = args[:customer_id].to_i
    @merchant_id  = args[:merchant_id].to_i
    @status       = args[:status].to_sym
    @created_at   = Time.parse(args[:created_at])
    @updated_at   = Time.parse(args[:updated_at])
  end
end
