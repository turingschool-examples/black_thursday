require_relative 'transaction'
class TransactionRepository
  def initialize(csv_path, parent)
    @transaction_csv = CSV.open(csv_path, headers: true, header_converters: :symbol)
    @parent = parent
    make_repository
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def make_repository
    @repository = {}
    @transaction_csv.read.each do |transaction|
      @repository[transaction[:id]] = Transaction.new(transaction, self)
    end
    return self
  end

  def all
    @repository.map do  |key, value|
      value
    end
  end

  def find_by_id(id)
    if @repository[id.to_s]
      @repository[id.to_s]
    else
      nil
    end
  end

  def find_all_by_invoice_id(invoice_search)
    all.find_all do |invoice|
      invoice.invoice_id.to_i == invoice_search.to_i
    end
  end

  def find_all_by_credit_card_number(card_number)
    all.find_all do |transaction|
      transaction.credit_card_number.to_i == card_number.to_i
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result.to_s
    end
  end

end
  