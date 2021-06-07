require 'csv'
require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at
  def initialize (data, repo)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @repo = repo
  end

  def self.create(attributes, repo)
    data_hash = {}
    time = Time.now.utc.strftime("%d-%m-%Y %H:%M:%S %Z")
    data_hash[:id] = repo.next_highest_id
    data_hash[:invoice_id] = attributes[:invoice_id].to_i
    data_hash[:credit_card_number] = attributes[:credit_card_number]
    data_hash[:credit_card_expiration_date] = attributes[:credit_card_expiration_date]
    data_hash[:result] = attributes[:result]
    data_hash[:created_at] = time
    data_hash[:updated_at] = time
    new(data_hash, repo)
  end

  def update(attributes)
    # time = Time.now.utc.strftime("%m-%d-%Y %H:%M:%S %Z")
    unless attributes[:credit_card_number].nil?
      @credit_card_number = attributes[:credit_card_number]
    end
    unless attributes[:credit_card_expiration_date].nil?
      @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    end
    unless attributes[:result].nil?
      @result = attributes[:result].to_sym
    end
    @updated_at = Time.now
  end
end
