require 'csv'
require 'pry'
require_relative '../lib/transaction'
require_relative '../lib/csv_parser'

class TransactionRepository

    include CsvParser

    attr_reader :transactions,
                :se

    def initialize(csv_file, se)
      @transactions = []
      @se = se
      parser(csv_file).each { |row| @transactions << Transaction.creator(row, self) }
    end

    def inspect
      "#<#{self.class} #{@transactions.size} rows>"
    end

    def all
      @transactions
    end

    def find_by_id(id)
      @transactions.find do |transaction|
        transaction.id == id
      end
    end

    def find_all_by_invoice_id(invoice_id)
      transactions.find_all do |transaction|
        transaction.invoice_id == invoice_id
      end
    end

    def find_all_by_credit_card_number(cc_number)
      transactions.find_all do |transaction|
        transaction.credit_card_number == cc_number
      end
    end

    def find_all_by_result(result)
      transactions.find_all do |transaction|
        transaction.result == result
      end
    end

    def find_invoice_by_id(invoice_id) # TESTS!!!
      se.invoices.find_by_id(invoice_id)
    end
end
