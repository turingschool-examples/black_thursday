require_relative 'transaction'

class TransactionRepository
  attr_accessor :transaction_repository

  def initialize(parent = nil)
    @se = parent
    @transaction_repository = []
  end

  def inspect
  "#<#{self.class} #{@repository.size} rows>"
  end

  def transaction(contents)
    contents.each do |column|
      @transaction_repository << Transaction.new(column, self)
    end
    self
  end

  def all
    transaction_repository.empty? ?  nil : transaction_repository
  end

  def find_by_id(find_id)
    transaction_repository.find {|transaction| transaction.id == find_id }
  end

  def find_all_by_invoice_id(find_id)
    transaction_repository.find_all {|transaction| transaction.invoice_id == find_id}
  end

  def find_all_by_credit_card_number(cc_number)
    transaction_repository.find_all {|transaction| transaction.credit_card_number == cc_number}
  end

  def find_all_by_result(result)
    transaction_repository.find_all {|transaction| transaction.result.downcase ==  result.downcase}
  end

  def find_invoice_by_transaction_invoice_id(id)
    @se.find_invoice_with_transaction_invoice_id(id)
  end

end
