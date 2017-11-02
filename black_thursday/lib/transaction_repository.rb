class TransactionRepository

  attr_reader :transactions, :parent

  def initialize(tran, parent)
    @transactions = load_csv(tran).map {|row| Transaction.new(row, self)}
    @parent = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @transactions
  end

  def find_by_id(id)
    return nil if id.class != Integer
    transactions.find {|transaction| transaction.id}
  end

  def find_all_by_invoice_id(id)
    return [] if id.class != Integer
    transactions.find_all {|transaction| transaction.invoice_id == id}
  end

  def find_all_by_credit_card(cc)
    return [] if cc.class != String
    transactions.find_all {|transaction| transaction.credit_card_number == cc}
  end



end
