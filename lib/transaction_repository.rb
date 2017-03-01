class TransactionRepository
  attr_reader :path,
              :engine

  def initialize(path, engine)
    @path = path
    @engine = engine
  end

  def csv
    @csv ||= CSV.open(path, headers:true, header_converters: :symbol)
  end

  def all
    @all ||= csv.map do |row|
      Transaction.new(row, self)
    end
  end

  def find_by_id(id)
    all.find do |transaction|
      transaction.id.to_i == id.to_i
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id.to_i
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number.to_i
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
