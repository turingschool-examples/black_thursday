require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(data_files, transaction_repo)
    @id = data_files[:id]
    @invoice_id = data_files[:invoice_id]
    @credit_card_number = data_files[:credit_card_number]
    @credit_card_expiration_date = data_files[:credit_card_expiration_date]
    @result = data_files[:result]
    @created_at = Time.parse(data_files[:created_at].to_s)
    @updated_at = Time.parse(data_files[:updated_at].to_s)
  end
end
