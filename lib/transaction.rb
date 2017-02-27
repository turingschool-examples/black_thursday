class Transaction
attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at, :repo

  def initialize(data_hash, tr)
    @id = data_hash[:id].to_i
    @invoice_id = data_hash[:invoice_id].to_i
    @credit_card_number = data_hash[:credit_card_number].to_i
    @credit_card_expiration_date = data_hash[:credit_card_expiration_date]
    @result = data_hash[:result]
    @created_at = Time.parse(data_hash[:created_at])
    @updated_at = Time.parse(data_hash[:updated_at])
    @path = {:type => "transaction"}
    @tr = tr
  end

  def invoice
    @path[:destination] = "invoice"
    repo.pass_id(invoice_id, @path)
  end
end