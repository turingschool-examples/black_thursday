require 'csv'
require 'time'
require_relative '../lib/transaction'
require 'pry'

class TransactionRepository
  attr_accessor :transactions_array
  attr_reader :contents, :engine

  def initialize(path, engine = '')
    @transactions_path = path
    @transactions_array = []
    @engine = engine
    pull_csv
    parse_csv
  end

  def pull_csv
    @contents = CSV.open @transactions_path, headers: true, header_converters: :symbol
  end

  def parse_csv
    # binding.pry
    @contents.each do |row|
      transactions_array << Transaction.new({
        :id                 => row[:id].to_i,
        :invoice_id         => row[:invoice_id].to_i,
        :credit_card_number => row[:credit_card_number].to_i,
        :credit_card_expiration_date => row[:credit_card_expiration_date].to_i,
        :result => "success",
        :created_at => Time.new(row[:created_at].to_i),
        :updated_at => Time.new(row[:updated_at].to_i)
      }, self)
    end
  end

  def all
    
  end
end

# The TransactionRepository is responsible for holding and searching our Transaction instances. It offers the following methods:
#
# all - returns an array of all known Transaction instances
# find_by_id - returns either nil or an instance of Transaction with a matching ID
# find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
# find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
# find_all_by_result - returns either [] or one or more matches which have a matching status
# The data can be found in data/transactions.csv so the instance is created and used like this:
#
# tr = TransactionRepository.new
# tr.from_csv("./data/transactions.csv")
# transaction = tr.find_by_id(6)
# # => <transaction>
