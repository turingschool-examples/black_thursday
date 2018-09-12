require_relative '../lib/transaction'
require_relative '../lib/repo_module'
require 'time'

class TransactionRepository
  include RepoModule

  attr_reader :data

  def initialize
    @data = []
  end

  def create(attributes)
    #all incoming data must be formatted as String datatype
    if attributes[:id] != nil
      #Coming From CSV
      hash = {
        id: attributes[:id].to_i,
        invoice_id: attributes[:invoice_id].to_i,
        credit_card_number: attributes[:credit_card_number],
        credit_card_expiration_date: attributes[:credit_card_expiration_date],
        result: attributes[:result].to_sym,
        updated_at: Time.parse(attributes[:updated_at]),
        created_at: Time.parse(attributes[:created_at])
        }
      transaction = Transaction.new(hash)
      @data << transaction
    else
      #Generated on the fly
      hash = {
        id: find_next_id,
        invoice_id: attributes[:invoice_id].to_i,
        credit_card_number: attributes[:credit_card_number],
        credit_card_expiration_date: attributes[:credit_card_expiration_date],
        result: attributes[:result].to_sym,
        updated_at: attributes[:updated_at],
        created_at: attributes[:created_at]
        }
      transaction = Transaction.new(hash)
      @data << transaction
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @data.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(number)
    @data.find_all do |transaction|
      transaction.credit_card_number == number
    end 
  end

end
