require_relative '../module/incravinable'

class TransactionRepository

  include Incravinable

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  attr_reader :all,
              :engine

  def initialize(path, engine)
    @all = []
    create_transactions(path)
    @engine = engine
  end

  def create_transactions(path)
    transactions = CSV.foreach(path, headers: true, header_converters: :symbol) do |transaction_data|
      transaction_hash = {
                  id:                          transaction_data[:id],
                  invoice_id:                  transaction_data[:invoice_id],
                  credit_card_number:          transaction_data[:credit_card_number],
                  credit_card_expiration_date: transaction_data[:credit_card_expiration_date],
                  result:                      transaction_data[:result],
                  created_at:                  Time.parse(transaction_data[:created_at]),
                  updated_at:                  Time.parse(transaction_data[:updated_at])
                }

    @all << Transaction.new(transaction_hash, self)
    end
  end

  def find_by_id(id)
    find_with_id(id, @all)
  end

  def find_all_by_invoice_id(id)
    @all.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(number)
    @all.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    highest_id = @all.max_by do |transaction|
      transaction.id
    end
    new_transaction = Transaction.new(attributes, self)
    new_transaction.new_id(highest_id.id + 1)
    @all << new_transaction
  end

  def update(id, attributes)
    found_transaction = @all.find do |transaction|
      transaction.id == id
    end
    if find_by_id(id) != nil
      found_transaction.update_cc_number(attributes[:credit_card_number])
      found_transaction.update_cc_expiration(attributes[:credit_card_expiration_date])
      found_transaction.update_result(attributes[:result])
    end
  end
end
