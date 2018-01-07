require 'time'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction)
    @id                 = transaction[:id].to_i
    @invoice_id         = transaction[:invoice_id]
    @credit_card_number = transaction[:credit_card_number]
    @result             = transaction[:result]
    @created_at         = Time.parse(transaction[:created_at])
    @updated_at         = Time.parse(transaction[:updated_at])
    @transaction_repo   = transaction[:transaction_repo]
  end

  def self.creator(row, parent)
    new({
      id: row[:id].to_i,
      invoice_id: row[:invoice_id],
      credit_card_number: row[:credit_card_number],
      result: row[:result],
      created_at: row[:created_at],
      updated_at: row[:updated_at],
      transaction_repo: parent
    })
  end

end
