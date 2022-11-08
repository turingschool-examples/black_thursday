require 'requirements'

class TransactionRepository
  include RepositoryQueries

  def initialize(records, engine)
    @records = create_records(records)
    @engine = engine
  end

  def all
    @records
  end

  def a_valid_id?(id)
    @records.any? do |record| record.id == id
    end
  end 

  def find_by_id(id)
    nil if !a_valid_id?(id)
    
    @records.find do |record|
      record.id == id
    end
  end
  
  def find_all_by_invoice_id(id)
    # nil if !a_valid_id?(id)
    
    @records.find_all do |record|
      record.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(cc)
    @records.find_all do |record|
      record.credit_card_number == cc
    end
  end

  def find_all_by_result(result)
    result.to_sym
    @records.find_all do |record|
      record.result == result
    end
  end

  def create(attributes)
    new_id = @records.last.id + 1
    @records << Transaction.new({ :id => new_id, 
                                      :invoice_id => attributes[:invoice_id], 
                                      :credit_card_number => attributes[:credit_card_number],
                                      :credit_card_expiration_date => attributes[:credit_card_expiration_date],
                                      :result => attributes[:result],
                                      :created_at => Time.now.to_s,
                                      :updated_at => Time.now.to_s}, self)
  end

  def update(id, attributes)
    @records.each do |record|
      record.update(attributes) if record.id == id
    end
  end

  def delete(id)
    @records.delete(find_by_id(id))
  end

  def create_records(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol, quote_char: '"'
    make_object(contents)
  end
  
  def make_object(contents)
    contents.map do |row|
      record = {
              :id => row[:id], 
              :invoice_id => row[:invoice_id],
              :credit_card_number => row[:credit_card_number],
              :credit_card_expiration_date => row[:credit_card_expiration_date],
              :result => row[:result],
              :created_at => row[:created_at],
              :updated_at => row[:updated_at],
            }
      Transaction.new(record, self)
    end
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end

