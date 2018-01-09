require 'time'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :result,
              :created_at,
              :updated_at,
              :transaction_repo,
              :credit_card_expiration_date

  def initialize(transaction)
    @id                          = transaction[:id].to_i
    @invoice_id                  = transaction[:invoice_id].to_i
    @credit_card_number          = transaction[:credit_card_number].to_i
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result                      = transaction[:result]
    @created_at                  = Time.parse(transaction[:created_at])
    @updated_at                  = Time.parse(transaction[:updated_at])
    @transaction_repo            = transaction[:transaction_repo]
  end

  def self.creator(row, parent)
    new({
      id: row[:id],
      invoice_id: row[:invoice_id],
      credit_card_number: row[:credit_card_number],
      result: row[:result],
      credit_card_expiration_date: row[:credit_card_expiration_date],
      created_at: row[:created_at],
      updated_at: row[:updated_at],
      transaction_repo: parent
    })
  end

  def invoice
    transaction_repo.find_invoice_by_id(invoice_id)
  end

end
