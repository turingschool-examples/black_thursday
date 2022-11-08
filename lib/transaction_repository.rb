require 'requirements'

class TransactionRepository
  include RepositoryQueries

  def initialize(records, engine)
    @records = create_records(records)
    @engine  = engine
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

  def make_record(contents)
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

