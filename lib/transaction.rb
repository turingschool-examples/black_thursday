require 'time'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  attr_accessor :repository

  def initialize(row, repository =nil)
    @id                          = row[:id].to_i
    @invoice_id                  = row[:invoice_id].to_i
    @credit_card_number          = row[:credit_card_number].to_i
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result                      = row[:result]
    @created_at                  = Time.parse(row[:created_at])
    @updated_at                  = Time.parse(row[:updated_at])
    @repository                  = repository
  end

  def invoice
    repository.sales_engine.invoices.find_by_id(self.invoice_id)
  end
end
