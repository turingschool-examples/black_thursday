require 'transaction'
require 'csv'

class TransactionRepository
  attr_reader :path,
              :all

  def initialize(path)
    @path = path
    @all  = read_file
  end

  def read_file
    rows = CSV.read(@path, headers: true, header_converters: :symbol)

    rows.map do |row|
      Transaction.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      id == transaction.id
    end
  end

  def find_by_invoice_id(id)
    @all.find do |transaction|
      id == transaction.invoice_id
    end
  end

  def find_by_credit_card_number(number)
    @all.find_all do |transaction|
      number == transaction.credit_card_number
    end
  end
end
