require_relative 'transaction'

class TransactionRepository
  attr_reader :all

  def initialize(transaction_data, parent = nil )
    @transaction_data = transaction_data
    @all = transaction_data.map { |row| Transaction.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    all.find { |transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all { |transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(cc_num)
    all.find_all { |transaction| transaction.credit_card_number == cc_num}
  end

  def find_all_by_result(result)
    all.find_all { |transaction| transaction.result == result}
  end


  def inspect
    @instance.nil? ? nil : "#<#{self.class} #{@instance.size} rows>"
  end

end
