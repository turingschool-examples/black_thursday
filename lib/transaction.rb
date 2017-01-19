require_relative '../lib/transaction_repo'
require 'csv'
require 'pry'
require 'time'

class Transaction

  attr_reader :parent,
              :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at
              
  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @invoice_id = data[:invoice_id].to_i
      @credit_card_number = data[:credit_card_number].to_i
      @credit_card_expiration_date = data[:credit_card_expiration_date]
      @result = data[:result]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def invoice 
    @parent.find_invoice_for_transaction(invoice_id)
  end

end