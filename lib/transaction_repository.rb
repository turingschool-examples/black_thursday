class TransactionRepository

  def initialize(transactions, engine)
    @transactions = create_transactions(transactions)
    @engine = engine
  end

  def all
    @transactions
  end

  def a_valid_id?(id)
    @transactions.any? do |instance| 
      instance.id == id
    end
  end 

  def find_by_id(id)
    nil if !a_valid_id?()
    
    @transactions.find do |invoice|
      invoice.id == id
    end
  end
  
  def find_all_by_invoice_id(id)
    nil if !a_valid_id?()
    
    @transactions.find_all do |invoice|
      invoice.id == id
    end
  end
  
  def find_all_by_credit_card_number(id)
    nil if !a_valid_id?()
    
    @transactions.find_all do |invoice|
      invoice.id == id
    end
  end

  def create(attribute)
    new_transaction = @transactions.last.id + 1
    @transactions << Transaction.new(attributes, self)
  end

  def update(id, attribute)
    @transactions.each do |invoice|
      if invoice.id == id
        transaction_new_status = invoice.name.replace(attribute)
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

