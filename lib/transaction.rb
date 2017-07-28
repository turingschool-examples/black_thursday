class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :tr

  def initialize(id, invoice_id, credit_card_number,
                credit_card_expiration_date, result,
                created_at, updated_at, tr)
    @id = id
    @invoice_id = invoice_id
    @credit_card_number = credit_card_number
    @credit_card_expiration_date = credit_card_expiration_date
    @result = result
    @created_at = Time.parse(created_at)
    @updated_at = Time.parse(updated_at)
    @tr = tr
  end
end
