require_relative 'transaction'
require 'csv'

class TransactionRepository

  attr_reader :sales_engine,
              :file_path,
              :id_repo

  def initialize(file_path, sales_engine)
    @file_path    = file_path
    @sales_engine = sales_engine
    @id_repo      = {}
    load_repo
  end

  def load_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      transaction_identification = row[:id]
      transaction = Transaction.new(row, self)
      @id_repo[transaction_identification.to_i] = transaction
    end
  end

  def all
    id_repo.map do |id, transaction_instance|
      transaction_instance
    end
  end

  def find_by_id(id)
    id_repo[id]
  end

  def find_all_by_invoice_id(invoice_id)
    id_repo.values.select do |transaction_instance|
      transaction_instance.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(cc_num)
    id_repo.values.select do |transaction_instance|
      transaction_instance.credit_card_number == cc_num
    end
  end

  def find_all_by_result(result)
    id_repo.values.select do |transaction_instance|
      transaction_instance.result == result
    end
  end

  def transaction_repo_to_se_invoice(invoice_id)
    @sales_engine.invoice_by_invoice_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

end
