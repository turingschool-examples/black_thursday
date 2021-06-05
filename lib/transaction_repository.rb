class TransactionRepository
  attr_reader :all
  def initialize(path)
    @all = []
    create_transactions(path)
  end

  def create_transactions(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card)
    @all.find_all do |transaction|
      transaction.credit_card_number == credit_card
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    new_transaction = Transaction.create(attributes)
  end
end
