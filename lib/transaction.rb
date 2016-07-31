require "bigdecimal"
require "time"
require 'pry'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :parent

  def initialize(item_data, parent=nil)
              @id                    = item_data[:id].to_i
              @invoice_id            = item_data[:invoice_id].to_i
              @credit_card_number    = item_data[:credit_card_number].to_i
              @credit_card_expiration_date = (item_data[:credit_card_expiration_date]).to_i
              @result                = item_data[:result]
              @created_at            = Time.parse(item_data[:created_at])
              @updated_at            = Time.parse(item_data[:updated_at])
              @parent                = parent
  end
end
