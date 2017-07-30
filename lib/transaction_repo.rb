class TransactionRepo
  attr_reader :transactions

  def initialize(filename, se=nil)
    @transactions = {}
    open_file(filename)
  end

  def open_file(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      transactions[row[:id].to_i] = Transaction.new(row, self)
    end
  end

  def all
    transactions.values
  end

  def find_by_id(id)
    transactions[id]
  end

  def find_all_by_invoice_id(inv_id)
    all.find_all {|transaction| transaction.invoice_id == inv_id}
  end

  def find_all_by_credit_card_number(cc_num)
    all.find_all {|transaction| transaction.cc_num == cc_num}
  end

  def find_all_by_result(status)
    all.find_all{|transaction| transaction.result == status}
  end
end
