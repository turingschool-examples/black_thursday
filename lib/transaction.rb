class Transaction
attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at, :tr

  def initialize(data_hash, transaction_repo)
    @id                          = data_hash[:id].to_i
    @invoice_id                  = data_hash[:invoice_id].to_i
    @credit_card_number          = data_hash[:credit_card_number].to_i
    @credit_card_expiration_date = data_hash[:credit_card_expiration_date]
    @result                      = data_hash[:result]
    @created_at                  = Time.parse(data_hash[:created_at])
    @updated_at                  = Time.parse(data_hash[:updated_at])
    @tr                          = transaction_repo
  end

  def invoice
    tr.se.invoices.find_by_id(invoice_id)
  end

end