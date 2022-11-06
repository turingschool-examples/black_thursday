require 'time'
class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result,
              :created_at, :updated_at, :repo
  def initialize(attributes, repo = nil)
    @id = attributes[:id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @credit_card_number = attributes[:credit_card_number]
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    @result = attributes[:result]
    @created_at = time_converter(attributes[:created_at])
    @updated_at = time_converter(attributes[:updated_at])
    @repo = repo
  end

  def time_converter(attributes)
    return unless attributes
    Time.parse(attributes)
  end
end
