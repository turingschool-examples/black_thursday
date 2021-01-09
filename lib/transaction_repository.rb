require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions

  def initialize(file_path, engine)
    @engine = engine
    @transactions = create_repository(file_path)
  end

  def create_repository(file_path)
    file = CSV.readlines(file_path, headers: true, header_converters: :symbol)
    file.map do |row|
      Transaction.new(row)
    end
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id.to_i == id
    end
  end

  def find_all_by_invoice_id(id)
    @transactions.find_all do |transaction|
      transaction.id.to_i == id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number.to_s
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result.to_s
    end
  end

  def max_transaction_id
    @transactions.max_by do |transaction|
      transaction.id
    end.id
  end

  def create(attributes)
    @transactions.push(Transaction.new({
                          id: (max_transaction_id + 1),
                          invpice_id: attributes[:invpice_id],
                          credit_card_number: attributes[:credit_card_number],
                          credit_card_expiration_date: attributes[:credit_card_expiration_date],
                          result: attributes[:result],
                          created_at: attributes[:created_at] = Time.now.to_s,
                          updated_at: attributes[:updated_at] = Time.now.to_s
                          }))
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    return nil if transaction.nil?
    attributes.each do |key, value|
      if value == attributes[:credit_card_number]
        transaction.credit_card_number = attributes[key]
      elsif value == attributes[:credit_card_expiration_date]
        transaction.credit_card_expiration_date = attributes[key]
      elsif value == attributes[:result]
        transaction.result = attributes[key]
      end
    end
    transaction.updated_at = Time.now
  end

  def delete(id)
    @transactions.delete(find_by_id(id))
  end

end
