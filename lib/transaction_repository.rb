class TransactionRepository
  attr_reader :all

  def initialize(transaction_path)
    @all = (
      transaction_objects = []
      CSV.foreach(transaction_path, headers: true, header_converters: :symbol) do |row|
        transaction_objects << Transaction.new(row)
      end
      transaction_objects)
  end

  def find_by_id(id)
    if (@all.any? do |transaction|
      transaction.id == id
    end) == true
      @all.find do |transaction|
        transaction.id == id
      end
    else
      nil
    end
  end

  def find_all_by_invoice_id(invoice_id)
    matched = []
    @all.each do |transaction|
      if transaction.invoice_id.to_i == invoice_id
        matched << transaction
      else
        []
      end
    end
    matched
  end

  def find_all_by_credit_card_number(credit_card_number)
    matched = []
    @all.each do |transaction|
      if transaction.credit_card_number.to_i == credit_card_number
        matched << transaction
      else
        []
      end
    end
    matched
  end

  def find_all_by_result(result)
    matched = []
    @all.each do |transaction|
      if transaction.result == result
        matched << transaction
      else
        []
      end
    end
    matched
  end

  def new_highest_id
    last = @all.last
    new_high = last.id.to_i
    new_high += 1
    new_high.to_s
  end

  def create(attribute)
  end
end
