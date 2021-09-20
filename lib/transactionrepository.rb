class TransactionRepository
  attr_reader :all

  def initialize(all)
    @all = all
  end

  def find_by_id(id)
    @all.find_all do |transaction|
      transaction.id == id
    end.pop
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |t|
      t.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(cc_num)
    @all.find_all do |t|
      t.credit_card_number == cc_num
    end
  end

  def find_all_by_result(result)
    @all.find_all do |t|
      t.result == result
    end
  end

  def create(attributes)
    id_max = @all.max_by {|transaction| transaction.id}
    attributes[:id] = id_max.id + 1
    new = Transaction.new(attributes)
    @all.push(new)
  end

  def update(id, attribute)

    updated_transaction = self.find_by_id(id)

      updated_transaction.credit_card_number = attribute[:credit_card_number]
      updated_transaction.credit_card_expiration_date = attribute[:credit_card_expiration_date]
      updated_transaction.result = attribute[:result]
      updated_transaction.updated_at = attribute[:updated_at]
    updated_transaction
  end

  def delete(id)
    x = (self.all).find_index(self.find_by_id(id))
    self.all.delete_at(x)
    self.all
  end
end
