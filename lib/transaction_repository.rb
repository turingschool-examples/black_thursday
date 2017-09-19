require 'csv'
require_relative 'transaction'
require_relative 'csv_loader'
require_relative 'search'


class TransactionRepository
  include CsvLoader
  include Search

  attr_reader :transactions

  def initialize(csv_file_path, engine)
    @transactions = create_items(csv_file_path, engine)
    @engine = engine
    return self
  end

  def create_items(csv_file_path, engine)
    create_instances(csv_file_path, 'Transaction', engine)
  end

  def all
    @transactions
  end

  def find_by_id(id_number)
    find_instance_by_id(@transactions, id_number)
  end

  def find_all_by_invoice_id(search_invoice_id)
    find_all_instances_by_invoice_id(@transactions, search_invoice_id)
  end

  def find_all_by_credit_card_number(search_card_number)
    search_card_number = search_card_number.to_i
    @transactions.find_all do |transaction|
      transaction.credit_card_number == search_card_number
    end
  end

  def find_all_by_result(search_result)
    search_result = search_result.downcase
    @transactions.find_all do |transaction|
      transaction.result == search_result
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
