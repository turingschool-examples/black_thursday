require_relative 'entry'
class TransactionRepository
  attr_reader :id, :invoice_id, :created_at, :all
  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(
        :id => row[:id].to_i,
        :invoice_id => row[:invoice_id],
        :credit_card_number => row[:credit_card_number],
        :credit_card_expiration_date => row[:credit_card_expiration_date],
        :result => row[:result],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        )
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    @all.find {|transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all {|transaction| transaction.invoice_id.to_i == invoice_id.to_i}
  end

  def find_all_by_credit_card_number(card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number.to_i == card_number.to_i
    end
  end

  def find_all_by_result(result)
    @all.find_all {|transaction| transaction.result == result}
  end

  def create(attributes)
    new_id = (@all.last.id + 1)
    @all << Transaction.new({
      :id => new_id,
      :invoice_id => attributes[:invoice_id],
      :credit_card_number => attributes[:credit_card_number],
      :credit_card_expiration_date => attributes[:credit_card_expiration_date],
      :result => attributes[:result],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]
      })
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    transaction.credit_card_number = attributes[:credit_card_number]
    transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date]
    transaction.result = attributes[:result]
    transaction.updated_at = Time.now
  end

  def delete(id)
    transaction = find_by_id(id)
    @all.delete(transaction)
  end

end
