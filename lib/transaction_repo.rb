class TransactionRepo
  attr_reader :all

  def initialize(csv_data, engine)
    create_transactions(csv_data)
    @engine = engine
  end

  def create_transactions(csv_data)
    transaction = CSV.open(csv_data, headers: true,
    header_converters: :symbol)

    @all = transaction.map do |transaction|
      Transaction.new(transaction, self)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(id)
    @all.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(number)
    @all.find_all do |transaction|
      transaction.credit_card_number == number.to_i
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result == result.to_sym
    end
  end

  def max_transaction_id
    @all.max_by do |transaction|
      transaction.id
    end.id
  end

  def create(attributes)
    @all.push(Transaction.new({
                            id: max_transaction_id + 1,
                            invoice_id: attributes[:invoice_id],
                            credit_card_number: attributes[:credit_card_number],
                            credit_card_expiration_date: attributes[:credit_card_expiration_date],
                            result: attributes[:result],
                            created_at: Time.now,
                            updated_at: Time.now
                          }, self))

  end

  def update(id, attributes)
      transaction = find_by_id(id)
      transaction.change_result(attributes[:result])
      transaction.update_time(attributes[:updated_at])
  end

  def delete(id)
    @all.reject! do |transaction|
      transaction.invoice_id == id
    end
  end
end
