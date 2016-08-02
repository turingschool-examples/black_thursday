require 'bigdecimal'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :parent

  def initialize(transaction_details, repo = nil)
    @id                 = transaction_details[:id].to_i
    @invoice_id         = transaction_details[:invoice_id].to_i
    @result             = transaction_details[:result]
    @created_at         = format_time(transaction_details[:created_at].to_s)
    @updated_at         = format_time(transaction_details[:updated_at].to_s)
    @parent             = repo
    @credit_card_number = transaction_details[:credit_card_number].to_i
    @credit_card_expiration_date =
      transaction_details[:credit_card_expiration_date]
  end

  def format_time(time_string)
    unless time_string == ""
      Time.parse(time_string)
    end
  end

  def invoice
    # binding.pry
    @parent.find_invoice_by_invoice_id(invoice_id)
  end

end
