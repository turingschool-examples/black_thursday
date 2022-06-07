require_relative './transaction'
class TransactionRepository
  attr_reader :transaction_path,
              :all,
              :invoice_id,
              :credit_card_number,
              :result,
              :created_at,
              :updated_at
  def initialize(transaction_path)
    @transaction_path = transaction_path
    @all = []

    CSV.foreach(@transaction_path, headers: true, header_converters: :symbol) do |row|
    @all << Invoice.new({@id => row[:id],
      @invoice_id => row[:invoice_id],
      @credit_card_number => row[:credit_card_number],
      @result => row[:result],
      @created_at => row[:created_at],
      @updated_at => row[:updated_at]})
    end
  end
end
