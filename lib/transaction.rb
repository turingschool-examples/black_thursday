require 'time'

class Transaction
  attr_reader :repo
  attr_accessor :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at

  def initialize(transaction_hash, repo)
    @id = transaction_hash[:id].to_i
    @invoice_id = transaction_hash[:invoice_id].to_i
    @credit_card_number = transaction_hash[:credit_card_number]
    @credit_card_expiration_date = transaction_hash[:credit_card_expiration_date]
    @result = transaction_hash[:result].to_sym
    @created_at = Time.parse(transaction_hash[:created_at].to_s)
    @updated_at = Time.parse(transaction_hash[:updated_at].to_s)
    @repo = repo
  end

  def to_hash
    self_hash = Hash.new
    self_hash[:id] = @id
    self_hash[:invoice_id] = @invoice_id
    self_hash[:credit_card_number] = @credit_card_number
    self_hash[:credit_card_expiration_date] = @credit_card_expiration_date
    self_hash[:result] = @result.to_sym
    self_hash[:created_at] = @created_at
    self_hash[:updated_at] = @updated_at
    self_hash
  end

end
