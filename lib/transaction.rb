require 'csv'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at
  def initialize (data, repo)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number].to_i
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result]
    @created_at = data[:created_at]
    @repo = repo
  end

  def self.create(attributes, repo)
    data_hash = {}
    data_hash[:id] = repo.next_highest_id
    data_hash[:invoice_id] = attributes[:invoice_id].to_i
    data_hash[:credit_card_number] = attributes[:credit_card_number].to_i
    data_hash[:credit_card_expiration_date] = attributes[:credit_card_expiration_date]
    data_hash[:result] = attributes[:result]
    data_hash[:created_at] = Time.now
    new(data_hash, repo)
  end
end
