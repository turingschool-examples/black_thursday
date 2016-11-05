require 'bigdecimal'
require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :created_at,
              :updated_at,
              :result,
              :parent

  def initialize(item_info = nil, repo = nil)
    return if item_info.to_h.empty?
    @parent                      = repo
    @id                          = item_info[:id].to_i
    @invoice_id                  = item_info[:invoice_id].to_i
    @credit_card_number          = item_info[:credit_card_number].to_i
    @credit_card_expiration_date = item_info[:credit_card_expiration_date].to_s
    @result                      = item_info[:result].to_s
    @created_at                  = Time.parse(item_info[:created_at].to_s)
    @updated_at                  = Time.parse(item_info[:updated_at].to_s)
  end

  def invoice
    parent.find_invoice_by_id(@invoice_id)
  end

end