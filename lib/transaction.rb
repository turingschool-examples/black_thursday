require_relative '../lib/transaction_repo'
require 'csv'
require 'pry'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :status,
              :created_at,
              :updated_at
              
  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @invoice_id = data[:invoice_id]
      @credit_card_number = data[:credit_card_number]
      @credit_card_expiration_date = data[:credit_card_expiration_date]
      @result = data[:result]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end
end