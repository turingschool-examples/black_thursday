require_relative 'transaction'

class TransactionRepository
  attr_reader :all

  def initialize
    @all =[]
  end

  def load_transactions(csv)
    csv.each do |transaction|
      transaction[:created_at] = Time.parse(transaction[:created_at])
      transaction[:updated_at] = Time.parse(transaction[:updated_at])
      @all << Transaction.new(transaction)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(id)
    @all.select do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(cc_num)
    @all.select do |transaction|
      transaction.credit_card_number == cc_num
    end
  end

  def find_all_by_result(result)
    @all.select do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    new_id = @all.max_by do |transaction|
      transaction.id
    end.id + 1
    attributes[:id] = new_id
    @all << Transaction.new(attributes)
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    transaction.update(attributes)
  end

  def delete(id)
    @all.delete_if do |transaction|
      transaction.id == id
    end
  end
end


















