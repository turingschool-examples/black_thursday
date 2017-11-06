require "time"

class Transaction
  attr_reader :id,
              :item_id
              :invoice_id
              :credit_card_number,
              :credit_card_expiration_date
              :result
              :created_at
              :updated_at
              :repository

  def initialize(item_info, parent)
    @id                           = item_info[:id].to_i
    @item_id                      = item_info[:item_id]
    @invoice_id                   = item_info[:invoice_id]
    @credit_card_number           = item_info[:credit_card_number]
    @credit_card_expiration_date  = item_info[:credit_card_expiration_date]
    @created_at                   = Time.parse(item_info[:created_at])
    @updated_at                   = Time.parse(item_info[:updated_at])
    @repository                   = parent
  end

  def merchant
    @repository.find_merchant(self.merchant_id)
  end

end
