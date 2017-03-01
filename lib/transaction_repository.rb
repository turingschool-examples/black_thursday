require './lib/helper'

class TransactionRepository

  attr_reader :all,
              :parent

  def initialize(transaction_data, parent)
    @all = transaction_data.map { |raw_data| Transaction.new(raw_data, self)}
    @parent = parent
  end

  def find_by_id(id)
    all.find do |transaction|
      id == transaction.id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      invoice_id == transaction.invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |transaction|
      credit_card_number == transaction.credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      result == transaction.result
    end
  end

  def find_invoice(invoice_id)
    parent.find_invoice_by_invoice_id(invoice_id)
  end
end