class TransactionRepository

  def initialize
    @transaction = transaction
  end

  def all
    @transaction
  end

  def a_valid_id?(id)
    @transaction.any? do |instance| instance.id == id
  end 

  def find_by_id(id)
    if !a_valid_id?()
      return nil
    else
      @transaction.find do |invoice|
        invoice.id == id
      end
    end
  end

  def find_all_by_invoice_id(id)
    if !a_valid_id?()
      return nil
    else
      @transaction.find do |invoice|
        invoice.id == id
      end
    end
  end

  def find_all_by_credit_card_number(id)
    if !a_valid_id?()
      return nil
    else
      @transaction.find do |invoice|
        invoice.id == id
      end
    end
  end

  def create(attribute)
    new_transaction = @transaction.last.id + 1
    @transaction << Transaction.new({:id => new_id, :name => attribute})
  end

  def update(id, attribute)
    @transaction.each do |invoice|
      if invoice.id == id
        transaction_new_status = invoice.name.replace(attribute)
        return transaction_new_status
      end
    end
  end

  def delete(id)
    @transaction.delete(find_by_id(id))
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end