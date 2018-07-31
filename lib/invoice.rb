# frozen_string_literal: true
require 'time'
# ./lib/invoice
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id
  attr_accessor :status,
                :updated_at

  @@max_id = 0

  def initialize(attributes)
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status = attributes[:status].to_sym
    @created_at = attributes[:created_at]
    @updated_at = Time.parse(attributes[:updated_at])
    update_max_id
  end

  def self.max_id
    @@max_id
  end

  def update_max_id
    @@max_id = @id if @id > @@max_id
  end

  def created_at
    Time.parse(@created_at)
  end

  def created_string
    @created_at
  end

  def self.create(attributes)
    id = @@max_id += 1
    new(id: id,
        customer_id: attributes[:customer_id],
        merchant_id: attributes[:merchant_id],
        status: attributes[:status],
        created_at: attributes[:created_at].to_s,
        updated_at: attributes[:updated_at].to_s)
  end
end
