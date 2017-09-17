#require_relative 'transaction_repository'
require 'bigdecimal'
require 'time'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :transaction_repository

  def initialize(transaction_repository, csv_info)
    @id = csv_info[:id].to_i
    @invoice_id = csv_info[:invoice_id].to_i
    @credit_card_number = csv_info[:credit_card_number].to_i
    @credit_card_expiration_date = csv_info[:credit_card_expiration_date]
    @result = csv_info[:result]
    @created_at = Time.parse(csv_info[:created_at])
    @updated_at = Time.parse(csv_info[:updated_at])
    @transaction_repository = transaction_repository
  end

  def invoice
    transaction_repository.sales_engine.invoices.find_by_id(invoice_id)
  end

end
