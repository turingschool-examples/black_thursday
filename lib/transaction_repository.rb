require_relative './enumerable'

class TransactionRepository
  include Enumerable
  attr_reader :all

  def initialize(file_path)
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new({
        id: row[:id],
        invoice_id: row[:invoice_id],
        credit_card_number: row[:credit_card_number].to_i,
        credit_card_expiration_date:  row[:credit_card_expiration_date],
        result: row[:result].downcase,
        created_at: row[:created_at],
        updated_at: row[:updated_at]
        })
    end
  end
end
