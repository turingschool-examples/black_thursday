require "time"

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :repository

  def initialize(item_info, parent)
    @id                           = item_info[:id].to_i
    @invoice_id                   = item_info[:invoice_id].to_i
    @credit_card_number           = item_info[:credit_card_number].to_i
    @credit_card_expiration_date  = item_info[:credit_card_expiration_date]
    @result                       = item_info[:result]
    @created_at                   = Time.parse(item_info[:created_at])
    @updated_at                   = Time.parse(item_info[:updated_at])
    @repository                   = parent
  end

  def merchant
    repository.find_merchant(self.merchant_id)
  end

  def invoice
    repository.find_invoice_by_invoice_id(self.id)
  end

  def invoice_items
    repository.find_invoice_items_by_invoice_id(self.invoice_id)
  end

end
