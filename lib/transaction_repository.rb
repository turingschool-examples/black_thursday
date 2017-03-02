require_relative "transaction"
require_relative "data_access"

class TransactionRepository
  attr_reader :all
  include DataAccess

  def initialize(parent)
    @all = []
    @parent = parent
  end

  def from_csv(path)
    file = CSV.open(path, headers: true, header_converters: :symbol)
    populate_repo(file)
  end

  def populate_repo(file)
  file.each do |row|
    transaction = Transaction.new({:id => row[:id].to_i,
      :invoice_id => row[:invoice_id].to_i,
      :credit_card_number => row[:credit_card_number].to_i,
      :credit_card_expiration_date =>row[:credit_card_expiration_date],
      :result => row[:result],
      :created_at => Time.parse(row[:created_at]),
      :updated_at => Time.parse(row[:updated_at])}, self)
      @all << transaction
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.select{ |transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.select{ |tran| tran.credit_card_number == credit_card_number}
  end

  def find_all_by_result(result)
    all.select{ |transaction| transaction.result == result}
  end
end