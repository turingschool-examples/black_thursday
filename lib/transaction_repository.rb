require 'csv'
require 'time'
require_relative './transaction'
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
    contents.each do |row|
      transactions_array << Transaction.new({
        :id                 => row[:id].to_i,
        :invoice_id         => row[:invoice_id].to_i,
        :credit_card_number => row[:credit_card_number].to_i,
        :credit_card_expiration_date => row[:credit_card_expiration_date],
        :result             => row[:result],
        :created_at         => Time.parse(row[:created_at]),
        :updated_at         => Time.parse(row[:updated_at])
      }, self)
    end
  end

  def all
    transactions_array
  end

  def find_by_id(find_id)
    transactions_array.find do |instance|
      instance.id == find_id
    end
  end

  def find_all_by_invoice_id(find_invoice_id)
    transactions_array.find_all do |instance|
      instance.invoice_id == find_invoice_id
    end
  end

  def find_all_by_credit_card_number(find_cc)
    transactions_array.find_all do |instance|
      instance.credit_card_number == find_cc
    end
  end

  def find_all_by_result(result)
    transactions_array.find_all do |instance|
      instance.result.downcase == result.downcase
    end
  end
  
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
