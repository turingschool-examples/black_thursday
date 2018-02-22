require_relative '../lib/transaction'
class TransactionRepository

  def initialize(filepath, parent = nil)
    @transactions = []
    load_transactions(filepath)
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def load_transactions(filepath)
    CSV.foreach(filepath, headers: true,
                header_converters: :symbol) do |data|
      @transactions << Transaction.new(data, self)
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(card_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == card_number
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end
end
