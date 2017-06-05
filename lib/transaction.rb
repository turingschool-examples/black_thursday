require 'time'


class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(params = {}, parent = nil)
    @parent                      = parent
    @id                          = params["id"].to_i
    @invoice_id                  = params["invoice_id"].to_i
    @result                      = params["result"]
    @credit_card_number          = params["credit_card_number"].to_i
    @credit_card_expiration_date = params["credit_card_expiration_date"]
    @created_at                  = Time.parse(params["created_at"])
    @updated_at                  = Time.parse(params["updated_at"])
  end

  def invoice
    @parent.invoice_id_to_se(self.invoice_id)
  end
end
