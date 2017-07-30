require_relative 'transaction'

class TransactionRepository
  attr_reader :repository
  def initialize(data, sales_engine = nil)
    @sales_engine = sales_engine
    @repository   = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Transaction.new(data, self)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    repository[id]
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def fetch_invoice_id_from_transactions(id)
    @sales_engine.fetch_invoice_id_from_transactions(id)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
