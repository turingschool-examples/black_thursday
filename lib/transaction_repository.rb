class TransactionRepository

  def initialize(transactions, engine)
    @transactions = create_transactions(transactions)
    @engine = engine
  end

  def all
    @transactions
  end

  def a_valid_id?(id)
    @transactions.any? do |transaction| transaction.id == id
  end 

  def find_by_id(id)
    nil if !a_valid_id?(id)
    
    @transactions.find do |transaction|
      transaction.id == id
    end
  end
  
  def find_all_by_invoice_id(id)
    # nil if !a_valid_id?(id)
    
    @transactions.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(cc)
    @transaction.find_all do |transaction|
      transaction.credit_card_number == cc
    end
  end

  def create(attributes)
    new_id = @transaction.last.id + 1
    @transaction << Transaction.new({ :id => new_id, 
                                      :invoice_id => attributes[:invoice_id], 
                                      :credit_card_number => attributes[:credit_card_number],
                                      :credit_card_expiration_date => attributes [:credit_card_expiration_date],
                                      :result => attributes[:result],
                                      :created_at => Time.now,
                                      :updated_at => Time.now}, self)
  end

  def update(id, attribute)
    @transaction.each do |transaction|
      if transaction.id == id
        transaction_new_status = transaction.name.replace(attribute)
        return transaction_new_status
      end
    end
  end

  def delete(id)
    @transactions.delete(find_by_id(id))
  end


  def create_transactions(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_transaction_object(contents)
  end
  
  def make_transaction_object(contents)
    contents.map do |row|
      transaction = {
              :id => row[:id].to_i, 
              :invoice_id => row[:invoice_id].to_i,
              :credit_card_number => row[:credit_card_number].to_i,
              :credit_card_expiration_date => row[:credit_card_expiration_date].to_i,
              :result => row[:result].to_sym,
              :created_at => row[:created_at],
              :updated_at => row[:updated_at],
            }
      Transaction.new(transaction, self)
    end
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
end
