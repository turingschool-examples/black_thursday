require_relative 'transaction'
require 'csv'

class TransactionRepository

  attr_reader :all

  def initialize(file_path, parent = nil)
    @parent = parent
    @all = []
    populate_transactions(file_path)
  end

  def populate_transactions(file_path)
    CSV.foreach(file_path, row_sep: :auto, headers: true) do |line|
      self.all << Transaction.new(line, self)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result == result
    end
  end

  def invoice_id_to_se(invoice_id)
    @parent.invoice_by_invoice_id(invoice_id)
  end

  def inspect
   "#<#{self.class} #{@all.size} rows>"
  end

end
